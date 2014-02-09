class Filmedhere.Routers.Films extends Backbone.Router
  routes:
    '': 'index'
    'films/:id': 'show'
  
  initialize: ->
    @collection = new Filmedhere.Collections.Films()
    @collection.fetch()
    
  index: ->
    view = new Filmedhere.Views.FilmsIndex(collection: @collection)
    $('#container').html(view.render().el)

  show: (id) ->
    film = @collection.get(id)
    title = film.get('title')
    alert "Film #{title}"