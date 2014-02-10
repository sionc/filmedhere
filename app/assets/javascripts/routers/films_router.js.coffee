class Filmedhere.Routers.Films extends Backbone.Router
  routes:
    '': 'index'
    'films/:id': 'show'
  
  initialize: ->
    # Fetch all the film records with associated location data
    @collection = new Filmedhere.Collections.Films()
    @collection.fetch()
    
  index: ->
    # Render the index view
    view = new Filmedhere.Views.FilmsIndex(collection: @collection)
    $('#container').html(view.render().el)

  show: (id) ->
    # For testing purposes only, check whether we can access a single film
    film = @collection.get(id)
    title = film.get('title')
    alert "Film #{title}"