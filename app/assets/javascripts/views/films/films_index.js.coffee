class Filmedhere.Views.FilmsIndex extends Backbone.View

  template: JST['films/index']
  map = null
  markers = []
  
  initialize: ->
    google.maps.event.addDomListener window, 'load',  @initializeMap
    @collection.on 'sync', @renderMarkers, this    
   
  initializeMap: ->
    mapOptions = 
      center: new google.maps.LatLng 37.7674159,-122.4747325
      zoom: 13
    
    map = new google.maps.Map document.getElementById('map-canvas'), mapOptions   
      
  renderMarkers: ->
    @createMarkers @collection
    
    # Rendering the collection in the container
    $(@el).html(@template(films: @collection))
    this
    
  createMarkers: (@collection) -> 
    @collection.each((film) ->
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
    )
