require 'spec_helper'

describe FilmingLocationService do
  
  describe '#update_filming_location_data,' do
    before(:each) do
       @sfds = SFDataService.new
       @gps = GooglePlacesService.new
       @fls = FilmingLocationService.new
    end
    
    context "when no filming locations exist," do
      it "should create a new film record." do
        expect {
          @fls.update_filming_location_data
        }.to change(Film, :count).by(2)
      end
      
      it "should create a new location record." do
        expect {
          @fls.update_filming_location_data
        }.to change(Location, :count).by(2)
      end
      
      it "should create a new filming location record." do
        expect {
          @fls.update_filming_location_data
        }.to change(FilmingLocation, :count).by(2)
      end
    end
 
    context "when the filming locations already exist," do
      before(:each) do
        @fls.update_filming_location_data
      end
      
      it "should not create a new film record." do
        expect {
          @fls.update_filming_location_data
        }.to change(Film, :count).by(0)
      end
      
      it "should not create a new location record." do
        expect {
          @fls.update_filming_location_data
        }.to change(Location, :count).by(0)
      end
      
      it "should not create a new filming location record." do
        expect {
          @fls.update_filming_location_data
        }.to change(FilmingLocation, :count).by(0)
      end
    end
    
  end
  
end