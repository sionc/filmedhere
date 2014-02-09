class Filmedhere.Views.FilmsIndex extends Backbone.View

  template: JST['films/index']
  
  events:
    'submit #film-search': 'updateMap'
  
  map = null
  sf = null
  markers = []
  filmIdsByTitleReleaseYear = {}
  
  initialize: ->
    sf = new google.maps.LatLng 37.7674159,-122.4747325
    google.maps.event.addDomListener window, 'load', @initializeMap
    @collection.on 'sync', @initializeUIElements, this    
   
  initializeMap: ->
    mapOptions = 
      center: sf
      zoom: 12
    
    map = new google.maps.Map document.getElementById('map-canvas'), mapOptions
  
  initializeUIElements: ->
    for film in @collection.models
      @createMarker film
      key = film.get('title') + ' (' + film.get('release_year') + ')' 
      filmIdsByTitleReleaseYear[key] = film.get('id')
   
    # Rendering the collection in the container
    $(@el).html(@template(films: @collection))
    this
    
    $('#film-search-textbox').autocomplete(
      source: Object.keys filmIdsByTitleReleaseYear
    )
  
  updateMap: (event) ->
    event.preventDefault()
    nameReleaseYear = $('#film-search-textbox').val()
    film = @collection.get(filmIdsByTitleReleaseYear[nameReleaseYear])
    @clearMarkers()
    @createMarker film
  
  createMarker: (film) -> 
    for filmLoc in film.get 'locations'
      lat = filmLoc['latitude']
      lng = filmLoc['longitude']
      latLng = new google.maps.LatLng lat, lng
      marker = new google.maps.Marker(
        position: latLng
        map: map
        title: film.get('title') + '_' + latLng
      )
      markers.push marker

  clearMarkers: ->
    for marker in markers
      marker.setMap null
    
    markers.length = 0