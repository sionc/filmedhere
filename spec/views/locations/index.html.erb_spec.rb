require 'spec_helper'

describe "locations/index" do
  before(:each) do
    assign(:locations, [
      stub_model(Location,
        :raw_address => "Raw Address",
        :formatted_address => "Formatted Address",
        :latitude => "9.99",
        :longitude => "10.99",
        :icon_url => "MyText",
        :name => "Name",
        :rating => "1.0",
        :google_places_id => "Google Places"
      ),
      stub_model(Location,
        :raw_address => "Raw Address",
        :formatted_address => "Formatted Address",
        :latitude => "9.99",
        :longitude => "10.99",
        :icon_url => "MyText",
        :name => "Name",
        :rating => "1.0",
        :google_places_id => "Google Places"
      )
    ])
  end

  it "renders a list of locations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Raw Address".to_s, :count => 2
    assert_select "tr>td", :text => "Formatted Address".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Google Places".to_s, :count => 2
  end
end
