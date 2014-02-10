# This service is used for creating records in the database based on the latest filming location info.
class FilmingLocationService
  
  # lat long around which location resolution needs to happen 
  # since we are just looking for locations around SF for now, use a constant for reference lat long
  SF_LAT_LONG = "37.7833,-122.4167"
  
  # search radius in terms of meters 
  # SF is around 600 km^2, 20000 meters or 20 km gives us a search radius of 20 * 20 * 3.14 ~ 1256.63
  SEARCH_RADIUS = 20000
   
  # Initializes the service
  #
  # This service utilizes two other services:
  #   SFDataService - for fetching the latest filming location records
  #   GooglePlacesService - for fetching lat long values for locations returned by SFDataService
  def initialize
    @sf_data_service = SFDataService.new
    @google_places_service = GooglePlacesService.new
  end
  
  # Creates records in the database based on the latest filming location info
  #
  # This method creates a new film, location and filming location record when a new filming location result is found.
  # It fetches the latest filming location info using SFDataService.
  # When a new location result is encountered, it attempts to fetch the lat long for that location and then proceeds to
  # create a location, film and filming location record. If a location cannot be resolved, it skips the result. 
  # If the filming location already exists, then it moves to the next available location result in the collection.
  # If no new locations were found, no records will be inserted into the database.
  #
  # This method is intended to be called periodically by a background task (perhaps, once a day or once a week)
  def update_filming_location_data
    
    # fetch the filming location results
    fl_results = @sf_data_service.filming_location_results || []
    
    # loop through each result and create film and location records 
    # if they don't already exist
    fl_results.each do |fl_result|
      title = fl_result["title"]
      release_year = fl_result["release_year"]
      raw_address = fl_result["locations"]
      fun_facts = fl_result["fun_facts"]
      
      # skip to the next result if either title or location is not available
      next if title.nil? or raw_address.nil?
      
      # attempt to create a location record if it doesn't already exist
      location = Location.where(:raw_address => raw_address).first
      if (location.nil?)
        # attempt to resolve address to get an exact location and other location details
        loc_result = @google_places_service.resolve_location(raw_address, SF_LAT_LONG, SEARCH_RADIUS)
        
        # skip to the next result if we can't resolve the location
        next if loc_result.nil?
        
        # attempt to create a new location record based on the resolved location
        location = create_location_record(raw_address, loc_result)
      end
      
      # attempt to create a new film record if it doesn't already exist
      # create a film only if the location can be resolved
      film = Film.where(:title => title, :release_year => release_year).first
      if (film.nil?)
        film = create_film_record(fl_result)
      end
      
      # if the association between film and location does not exist, then create one
      filming_location = FilmingLocation.where(:film_id => film.id, :location_id => location.id).first
      if (filming_location.nil?)
        filming_location = create_filming_location_record(film.id, location.id, fun_facts)
      end  
    end    
    
    nil

  end
  
private
  
  # Build a comma separated string "Actor 1, Actor 2, Actor 3" for the listed actors in a 
  # filming location result
  def build_actors_str (filming_location_result)
    
    # result set contains the actors as separate key value pairs
    # such as actor_1 => Actor 1, actor_2 => Actor 2, etc.
    # We need to combine the actor values so that we can store them
    # in one column as a comma separated set e.g "Actor 1, Actor 2, Actor 3"
    actors_arr = []
    filming_location_result.keys.each do |key|
      if key.start_with? "actor"
        actors_arr << filming_location_result[key]
      end
    end
    actors_str = actors_arr.length > 0 ? actors_arr.join(", ") : nil
    
  end
  
  # Creates a new film based on filming location result
  def create_film_record (filming_location_result)
    
    # create a new film object
    film = Film.new(:title => filming_location_result["title"], 
                    :release_year => filming_location_result["release_year"], 
                    :production_company => filming_location_result["production_company"], 
                    :distributor => filming_location_result["distributor"], 
                    :director => filming_location_result["director"], 
                    :writers => filming_location_result["writer"], 
                    :actors => build_actors_str(filming_location_result))
                    
    film_attrs =  "{title : #{film[:title]}, release_year : #{film[:release_year]}}" 
    
    # attempt to create a film record in the database
    if film.save
      Rails.logger.info "Successfully created a new film record: " + film_attrs 
      film
    else
      Rails.logger.warn "Failed to create a new film record: " + film_attrs
      nil
    end
    
  end
  
  # Creates a new location record based on the unformatted address and location result
  def create_location_record (raw_address, location_result)
      
    # create a new location object
    location = Location.new(:raw_address => raw_address, 
                            :formatted_address => location_result["formatted_address"], 
                            :latitude => location_result["geometry"]["location"]["lat"], 
                            :longitude => location_result["geometry"]["location"]["lng"], 
                            :icon_url => location_result["icon"],
                            :name => location_result["name"], 
                            :rating => location_result["rating"], 
                            :google_places_id => location_result["id"])
                            
    location_attrs =  "{raw_address : #{location[:raw_address]}, " +
                       "latitude : #{location[:latitude]}, " +
                       "longitude : #{location[:longitude]}}" 
    
    # attempt to create a location record in the database
    if location.save
      Rails.logger.info "Successfully created a new location record: " + location_attrs 
      location
    else
      Rails.logger.warn "Failed to create a new location record: " + location_attrs
      nil
    end
    
  end
  
  # Creates a new filming location record using the film_id, location_id and fun_facts
  def create_filming_location_record (film_id, location_id, fun_facts)
      
    # create a new filming location object
    filming_location = FilmingLocation.new(:film_id => film_id, 
                                           :location_id => location_id, 
                                           :fun_facts => fun_facts)
                                           
    filming_location_attrs =  "{film_id : #{filming_location[:film_id]}, " +
                               "location_id : #{filming_location[:location_id]}}" 
    
    # attempt to create a filming location record in the database
    if filming_location.save
      Rails.logger.info "Successfully created a new filming location record: " + filming_location_attrs 
      filming_location
    else
      Rails.logger.warn "Failed to create a new filming location record: " + filming_location_attrs
      nil
    end
    
  end
  
end