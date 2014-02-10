# This service is used to fetch lat long and other relevant information about a location
class GooglePlacesService
  include HTTParty
  base_uri "https://maps.googleapis.com"
  default_params :key => "AIzaSyBBTQP6JubPX7SVQ83qSO7iAcOB2-TL_tM", :sensor => "false"
  default_timeout 10
  
  # Returns lat long and other relevant information about a location based on it's address string
  # 
  # This method fetches the lat long information using the Google Places API
  # It returns nil if a location cannot be resolved.
  #
  # Params:
  #   raw_address - address of the location, or search term used to describe the location
  #   reference_lat_long - closest reference lat long for the location
  #   search_radius - radius of the search in meters from the closest reference lat long
  # 
  # Sample response for gps.resolve_location("655 Montgomery st", "37.7833,-122.4167", 20000):
  #   {"geometry"=>{"location"=>{"lat"=>37.795235, "lng"=>-122.403607}}, 
  #   "icon"=>"http://maps.gstatic.com/mapfiles/place_api/icons/geocode-71.png", 
  #   "id"=>"c6158d7d6f3213c0050750fe198ae5bfdd5cb2d2", 
  #   "name"=>"655 Montgomery St", 
  #   "reference"=>"CqQBmwAAAMQdSM1vH71a3kJumtghL_Ld43S2i31DN7lKiOOArlTSZ4kBHwFQWOzSLm3
  #                 Y7kArJXhI7nQmykmD9w7D3TPgR2S_6jLVKSBSoZj6YKAU-7HefKjzvRgqtSPS_upH0dLQ1uzX6RtfeExA
  #                 4U76uiOEyHNaOotYqY-2NhQ0TqW2wDLVJhQJSz_sVoYUZXtYxpomZO3LCXZh1RtSJZ6kTAuhe24SEDEc
  #                 0yCm6JGOiGZRyH-lcQgaFIS_IE90kgwFWNcL1bakJrFknzwl", 
  #   "types"=>["street_address"], 
  #   "vicinity"=>"San Francisco"}
  # 
  def resolve_location(raw_address, reference_lat_long, search_radius)
    # resolve the address by calling google places and fetching details about the address
    options={:query => {:location => reference_lat_long, 
                        :radius => search_radius,
                        :keyword => raw_address}}
              
    response = self.class.get("/maps/api/place/nearbysearch/json?", options)     
    res_loc = nil;
    if (response.code == 200)
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