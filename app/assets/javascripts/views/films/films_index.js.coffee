class Filmedhere.Views.FilmsIndex extends Backbone.View

  template: JST['films/index']
  
  initialize: ->
    @collection.on('sync', @render, this)
    google.maps.event.addDomListener(window, 'load', @map_initialize);
   
  map_initialize: ->
    myLatlng = new google.maps.LatLng(37.7674159,-122.4747325)
    
    mapOptions = 
      center: new google.maps.LatLng(37.7674159,-122.4747325)
      zoom: 13

    map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions)

    contentString = '<div id="content">'+
          '<div id="siteNotice">'+
          '</div>'+
          '<h1 id="firstHeading" class="firstHeading">Uluru</h1>'+
          '<div id="bodyContent">'+
          '<p><b>Uluru</b>, also referred to as <b>Ayers Rock</b>, is a large ' +
          'sandstone rock formation in the southern part of the '+
          'Heritage Site.</p>'+
          '<p>Attribution: Uluru, <a href="http://en.wikipedia.org/w/index.php?title=Uluru&oldid=297882194">'+
          'http://en.wikipedia.org/w/index.php?title=Uluru</a> '+
          '(last visited June 22, 2009).</p>'+
          '</div>'+
          '</div>';

    infowindow = new google.maps.InfoWindow(
      content: contentString
      maxWidth: 200  
    )

    marker = new google.maps.Marker(
      position: myLatlng
      map: map
      title: 'Test Window'
    )
      
    google.maps.event.addListener(marker, 'click', -> infowindow.open(map,marker))      
      
  render: ->
    $(@el).html(@template(films: @collection))
    this
