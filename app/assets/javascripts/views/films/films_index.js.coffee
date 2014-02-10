class Filmedhere.Views.FilmsIndex extends Backbone.View

  template: JST['films/index']
  
  events:
    # update the map markers when a new search is executed
    'submit #film-search': 'updateMap'
  
  # initialize constants and other variables
  SF_CENTER_LAT = 37.7674159
  SF_CENTER_LNG = -122.4747325
  map = null
  sf = null
  markers = []
  filmIdsByTitleReleaseYear = {}
  
  initialize: ->
    # initialize the map
    google.maps.event.addDomListener window, 'load', @initializeMap
    
    # render the UI elements after all the film records have been fetched
    @collection.on 'sync', @initializeUIElements, this    
   
  initializeMap: ->
    sf = new google.maps.LatLng SF_CENTER_LAT, SF_CENTER_LNG
    
    mapOptions = 
      center: sf
      zoom: 13
    
    map = new google.maps.Map document.getElementById('map-canvas'), mapOptions
  
  initializeUIElements: ->
    for film in @collection.models
      # Create markers for each location associated with this film
      @createMarker film
      
      # Create a lookup table for autocomplete {'filmTitle (filmReleaseYear)' => filmId}
      key = film.get('title') + ' (' + film.get('release_year') + ')' 
      filmIdsByTitleReleaseYear[key] = film.get('id')
   
    # render the search control
    $(@el).html(@template(films: @collection))
    this
    
    # initialize the autocompletion search textbox
    $('#film-search-textbox').autocomplete(
      source: Object.keys filmIdsByTitleReleaseYear
    )
  
  updateMap: (event) ->
    event.preventDefault()
    
    # extract the 'title (release year)' from the search box
    titleReleaseYear = $('#film-search-textbox').val()
    
    # get the associated film using the id from the lookup table
    film = @collection.get(filmIdsByTitleReleaseYear[titleReleaseYear])
    
    # clear all existing markers
    @clearMarkers()
    
    # create a new marker for this film
    @createMarker film
  
  createMarker: (film) ->
    title = film.get('title')
    releaseYear = film.get('release_year')
    titleReleaseYear = title + ' (' + releaseYear + ')'
    
    # for each location associated with this film 
    for filmLoc in film.get 'locations'
      rawAddress = filmLoc['raw_address']
      titleAtRawAddress = title + ' @ ' + rawAddress
      
      # fetch the latitude and longitude
      lat = filmLoc['latitude']
      lng = filmLoc['longitude']
      
      # create a new a new marker using the lat long
      latLng = new google.maps.LatLng lat, lng
      marker = new google.maps.Marker(
        position: latLng
        map: map
        title: titleAtRawAddress
      )
      
      # initialize the content object for the info window
      infoWindowOptions = 
        header: titleReleaseYear
        content1: rawAddress  
        content2: 'San Francisco, CA'
      
      # Create an info window for this marker
      @createInfoWindow marker, infoWindowOptions
      
      # keep track of all markers on the page
      markers.push marker

  clearMarkers: ->
    # clear all current markers on the map 
    for marker in markers
      marker.setMap null
    
    markers.length = 0
    
  createInfoWindow: (marker, options) -> 
    # create the content for the info window
    contentString = 
      '<div>'+
        '<h5>'+options.header+'</h5>'+
        '<hr>'+
        '<div>'+
          '<p>'+options.content1+'</p>'+
          '<p>'+ options.content2+'</p>'+
        '</div>'+
      '</div>'
    
    # create a new info window
    infowindow = new google.maps.InfoWindow(
      content: contentString
      maxWidth: 300
    )
    
    # when a marker is clicked, open the info window
    google.maps.event.addListener marker, 'click', -> infowindow.open map, marker 