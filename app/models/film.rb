class Film < ActiveRecord::Base
  has_many :filming_locations
  has_many :locations, through: :filming_locations
end
