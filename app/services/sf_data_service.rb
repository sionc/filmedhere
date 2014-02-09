class SFDataService
  include HTTParty
  base_uri 'http://data.sfgov.org'
  default_timeout 10

  def filming_location_results(options={})
    # fetch the filming location data using httparty
    response = self.class.get('/resource/yitu-d5am.json', options)
    if (response.code == 200)
      # parsed response contains an array of all filming location results  
      response.parsed_response
    else
      Rails.logger.error "Failed to access SF Data endpoint (http://data.sfgov.org/resource/yitu-d5am.json). " +
                         "{response.code : #{response.code}, " +
                         "response.message : #{response.message}}"
      nil                        
    end
  end
end