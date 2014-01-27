require 'spec_helper'

describe "locations/new" do
  before(:each) do
    assign(:location, stub_model(Location,
      :raw_address => "MyString",
      :formatted_address => "MyString",
      :latitude => "9.99",
      :longitude => "9.99",
      :icon_url => "MyText",
      :name => "MyString",
      :rating => "9.99",
      :google_places_id => "MyString"
    ).as_new_record)
  end

  it "renders new location form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", locations_path, "post" do
      assert_select "input#location_raw_address[name=?]", "location[raw_address]"
      assert_select "input#location_formatted_address[name=?]", "location[formatted_address]"
      assert_select "input#location_latitude[name=?]", "location[latitude]"
      assert_select "input#location_longitude[name=?]", "location[longitude]"
      assert_select "textarea#location_icon_url[name=?]", "location[icon_url]"
      assert_select "input#location_name[name=?]", "location[name]"
      assert_select "input#location_rating[name=?]", "location[rating]"
      assert_select "input#location_google_places_id[name=?]", "location[google_places_id]"
    end
  end
end
