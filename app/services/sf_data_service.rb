# This service fetches information about the latest filming locations in San Francisco
class SFDataService
  include HTTParty
  base_uri 'http://data.sfgov.org'
  default_timeout 10
  
  # Returns information about all the filming locations in San Francisco
  # 
  # This method fetches the lat long information using the Google Places API
  # It returns nil if a location cannot be resolved.
  #
  # Params:
  #   options (optional) - check out http://rdoc.info/github/jnunemaker/httparty#Help_and_Docs for HTTParty options
  # 
  # Sample response for sfds.filming_location_results:
  #   [{"title"=>"A View to a Kill", "actor_1"=>"Roger Moore", "locations"=>"Port of San Francisco ", "release_year"=>"1985",
  #   "production_company"=>"Metro-Goldwyn Mayer", "distributor"=>"MGM/UA Entertainemnt Company", "actor_2"=>"Christopher
  #   Walken", "writer"=>"Richard Maibaum", "director"=>"John Glen"}, {"title"=>"A View to a Kill", "actor_1"=>"Roger Moore",
  #   "locations"=>"Lefty O' Doul Drawbridge/ 3rd Street Bridge (3rd Street, China Basin)", "fun_facts"=>"This is SF's only
  #   drawbridge, and was named after Francis Joseph \"Lefty\" O'Doul, a local baseball hero.", "release_year"=>"1985",
  #   "production_company"=>"Metro-Goldwyn Mayer", "distributor"=>"MGM/UA Entertainemnt Company", "actor_2"=>"Christopher
  #   Walken", "writer"=>"Richard Maibaum", "director"=>"John Glen"}]
  # 
  def filming_location_results(options={})
    # fetch the filming location data using httparty
    response = self.class.get('/resource/yitu-d5am.json', options)
    results = nil
    if (response.code == 200)
      # parsed response contains an array of all filming location results  
      results = response.parsed_response
    else
      Rails.logger.error "Failed to access SF Data endpoint (http://data.sfgov.org/resource/yitu-d5am.json). " +
                         "{response.code : #{response.code}, " +
                         "response.message : #{response.message}}"                        
    end
    results
  end
end