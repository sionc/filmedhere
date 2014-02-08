class Filmedhere.Views.FilmsIndex extends Backbone.View

  template: JST['films/index']
  map = null
  markers = []
  
  initialize: ->
    google.maps.event.addDomListener window, 'load',  @initialize_map
    @collection.on 'sync', @render_markers, this    
   
  initialize_map: ->
    mapOptions = 
      center: new google.maps.LatLng 37.7674159,-122.4747325
      zoom: 13
    
    map = new google.maps.Map document.getElementById('map-canvas'), mapOptions   
      
  render_markers:  ->
    @collection.each((film) ->
      for film_loc in film.get 'locations'
        lat = film_loc['latitude']
        lng = film_loc['longitude']
        latLng = new google.maps.LatLng lat, lng
        marker = new google.maps.Marker(
          position: latLng
          map: map
          title: film.get('title') + '_' + latLng
        )
        markers.push marker
    )
    
    # Rendering the collection in the container
    $(@el).html(@template(films: @collection))
    this
