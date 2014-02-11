class Filmedhere.Collections.Films extends Backbone.Collection
  # Set the url to the location of films index on the server
  url: '/api/films'
  
  released_after: (year) -> 
     filtered = this.filter (film) -> film.get("release_year") >= year
     new Films filtered
