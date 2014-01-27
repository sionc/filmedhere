require 'spec_helper'

describe "locations/show" do
  before(:each) do
    @location = assign(:location, stub_model(Location,
      :raw_address => "Raw Address",
      :formatted_address => "Formatted Address",
      :latitude => "9.99",
      :longitude => "9.99",
      :icon_url => "MyText",
      :name => "Name",
      :rating => "9.99",
      :google_places_id => "Google Places"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/Raw Address/)
    expect(rendered).to match(/Formatted Address/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Google Places/)
  end
end
