json.array!(@locations) do |location|
  json.extract! location, :id, :raw_address, :formatted_address, :latitude, :longitude, :icon_url, :name, :rating, :google_places_id
  json.url location_url(location, format: :json)
end
