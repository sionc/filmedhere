require "spec_helper"

describe FilmsController do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/api/films").to route_to("films#index")
    end

    it "routes to #new" do
      expect(:get => "/api/films/new").to route_to("films#new")
    end

    it "routes to #show" do
      expect(:get => "/api/films/1").to route_to("films#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/api/films/1/edit").to route_to("films#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/api/films").to route_to("films#create")
    end

    it "routes to #update" do
      expect(:put => "/api/films/1").to route_to("films#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/api/films/1").to route_to("films#destroy", :id => "1")
    end

  end
end
