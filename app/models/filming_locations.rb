class FilmingLocations < ActiveRecord::Base
  belongs_to :films
  belongs_to :locations
end
