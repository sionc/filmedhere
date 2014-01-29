class GooglePlacesService
  include HTTParty
  base_uri "https://maps.googleapis.com"
  default_params :key => "AIzaSyBBTQP6JubPX7SVQ83qSO7iAcOB2-TL_tM", :sensor => "false"
  default_timeout 10
  
  def resolve_location(raw_address, reference_lat_long, search_radius)
    # resolve the address by calling google places and fetching details about the address
    options={:query => {:location => reference_lat_long, 
                        :radius => search_radius,
                        :keyword => raw_address}}
              
    response = self.class.get("/maps/api/place/nearbysearch/json?", options)
    
    res_loc = nil;
    if (response.code == 200 and response.message == "OK")
      # parsed response contains an array of resolved location results  
      results = response.parsed_response["results"]
      
      # if the result set has at least one result, then pick that as the resolved location.
      # Since we are performing a nearby search with an exact address and the result set is 
      # ordered by prominence (default behavior for nearby search), it is very likely
      # that the first result will be the most relevant.
      if results.length > 0 
        res_loc = results[0]
      else
        Rails.logger.error "Could not resolve location for address: #{raw_address}"
      end
    else
      Rails.logger.error "Failed to access SF Data endpoint (https://maps.googleapis.com. " +
                         "{response.code : #{response.code}, " +
                         "response.message : #{response.message}}"                        
    end
    res_loc
  end
end