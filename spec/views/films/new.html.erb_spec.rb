require 'spec_helper'

describe "films/new" do
  before(:each) do
    assign(:film, stub_model(Film,
      :title => "MyString",
      :release_year => 1,
      :production_company => "MyString",
      :distributor => "MyString",
      :director => "MyString",
      :writers => "MyString",
      :actors => "MyString"
    ).as_new_record)
  end

  it "renders new film form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", films_path, "post" do
      assert_select "input#film_title[name=?]", "film[title]"
      assert_select "input#film_release_year[name=?]", "film[release_year]"
      assert_select "input#film_production_company[name=?]", "film[production_company]"
      assert_select "input#film_distributor[name=?]", "film[distributor]"
      assert_select "input#film_director[name=?]", "film[director]"
      assert_select "input#film_writers[name=?]", "film[writers]"
      assert_select "input#film_actors[name=?]", "film[actors]"
    end
  end
end
