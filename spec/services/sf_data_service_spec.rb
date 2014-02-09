require 'spec_helper'

describe SFDataService do
  
  describe '#filming_location_results' do
    it "should return at least a one result" do
      sfds = SFDataService.new
      sfds.filming_location_results.should_not be_empty
    end
  end
  
end