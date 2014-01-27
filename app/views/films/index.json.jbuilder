json.array!(@films) do |film|
  json.extract! film, :id, :title, :release_year, :production_company, :distributor, :director, :writers, :actors
  json.url film_url(film, format: :json)
end
