require 'spec_helper'

describe "films/show" do
  before(:each) do
    @film = assign(:film, stub_model(Film,
      :title => "Title",
      :release_year => 1,
      :production_company => "Production Company",
      :distributor => "Distributor",
      :director => "Director",
      :writers => "Writers",
      :actors => "Actors"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Production Company/)
    expect(rendered).to match(/Distributor/)
    expect(rendered).to match(/Director/)
    expect(rendered).to match(/Writers/)
    expect(rendered).to match(/Actors/)
  end
end
