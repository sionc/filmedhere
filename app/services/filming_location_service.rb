class FilmingLocationService
   
  def initialize
    @sf_data_service = SFDataService.new
  end
  
  def update_filming_location_data
    # fetch the filming location results
    fl_results = @sf_data_service.filming_location_results || []
    
    # loop through each result and create film and location records 
    # if they don't already exist
    fl_results.each do |fl_result|
      title = fl_result["title"]
      release_year = fl_result["release_year"]
      
      # skip to the next result if the film already exists
      next if (Film.where(:title => title, :release_year => release_year).length > 0)
      
      # create a new film record
      create_film_record(fl_result)
    end
    return true 
  end
  
private
  
  def build_actors_str (filming_location_result)
    actors_arr = []
    filming_location_result.keys.each do |key|
      if key.start_with? "actor"
        actors_arr << filming_location_result[key]
      end
    end
    actors_str = actors_arr.length > 0 ? actors_arr.join(", ") : nil
  end
  
  def create_film_record (filming_location_result)
    film = Film.new(:title => filming_location_result["title"], 
                    :release_year => filming_location_result["release_year"], 
                    :production_company => filming_location_result["production_company"], 
                    :distributor => filming_location_result["distributor"], 
                    :director => filming_location_result["director"], 
                    :writers => filming_location_result["writer"], 
                    :actors => build_actors_str(filming_location_result))
    film_attrs =  "{title : #{film[:title]}, release_year : #{film[:release_year]}}" 
    if film.save
      Rails.logger.info "Successfully created a new film record: " + film_attrs 
    else
      Rails.logger.warn "Failed to create a new film record: " + film_attrs
    end
  end
  
end