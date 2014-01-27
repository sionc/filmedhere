class Location < ActiveRecord::Base
  has_many :filming_locations
  has_many :films, through: :filming_locations
end
