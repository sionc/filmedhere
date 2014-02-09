class Filmedhere.Views.FilmsIndex extends Backbone.View

  template: JST['films/index']
  
  events:
    'submit #film-search': 'updateMap'
  
  map = null
  sf = null
  markers = []
  
  initialize: ->
    sf = new google.maps.LatLng 37.7674159,-122.4747325
    google.maps.event.addDomListener window, 'load', @initializeMap
    @collection.on 'sync', @renderMarkers, this    
   
  initializeMap: ->
    mapOptions = 
      center: sf
      zoom: 13
    
    map = new google.maps.Map document.getElementById('map-canvas'), mapOptions
  
  renderMarkers: ->
    for film in @collection.models
      @createMarker film
    
    # Rendering the collection in the container
    $(@el).html(@template(films: @collection))
    this
  
  updateMap: (event) ->
    event.preventDefault()
    id = $('#film-search-textbox').val()
    film = @collection.get(id)
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