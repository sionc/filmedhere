class SFDataService
  include HTTParty
  base_uri 'http://data.sfgov.org'

  def filming_location_results(options={})
    response = self.class.get('/resource/yitu-d5am.json', options)
    if (response.code == 200 and response.message == 'OK')
      response.parsed_response
    else
      Rails.logger.error "Failed to access SF Data endpoint (http://data.sfgov.org/resource/yitu-d5am.json). " +
                         "{response.code : #{response.code}, " +
                         "response.message : #{response.message}}"                        
    end
  end
end