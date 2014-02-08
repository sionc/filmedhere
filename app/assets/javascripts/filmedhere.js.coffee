window.Filmedhere =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: -> 
    new Filmedhere.Routers.Films()
    Backbone.history.start()

$(document).ready ->
  Filmedhere.initialize()
