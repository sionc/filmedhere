require 'spec_helper'

describe GooglePlacesService do
  
  describe '#resolved_location' do
    it "should resolve a valid SF address" do
      gps = GooglePlacesService.new
      gps.resolve_location("655 Montgomery st", "37.7833,-122.4167", 20000).should_not be_empty
    end
  end
  
end
