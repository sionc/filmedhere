require 'spec_helper'

describe "films/index" do
  before(:each) do
    assign(:films, [
      stub_model(Film,
        :title => "Title",
        :release_year => 1,
        :production_company => "Production Company",
        :distributor => "Distributor",
        :director => "Director",
        :writers => "Writers",
        :actors => "Actors"
      ),
      stub_model(Film,
        :title => "Title",
        :release_year => 1,
        :production_company => "Production Company",
        :distributor => "Distributor",
        :director => "Director",
        :writers => "Writers",
        :actors => "Actors"
      )
    ])
  end

  it "renders a list of films" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Production Company".to_s, :count => 2
    assert_select "tr>td", :text => "Distributor".to_s, :count => 2
    assert_select "tr>td", :text => "Director".to_s, :count => 2
    assert_select "tr>td", :text => "Writers".to_s, :count => 2
    assert_select "tr>td", :text => "Actors".to_s, :count => 2
  end
end
