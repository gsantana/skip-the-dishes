require "rails_helper"

RSpec.describe DishesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/dishes").to route_to("dishes#index")
    end

    it "routes to #new" do
      expect(:get => "/dishes/new").to route_to("dishes#new")
    end

    it "routes to #show" do
      expect(:get => "/dishes/1").to route_to("dishes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/dishes/1/edit").to route_to("dishes#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/dishes").to route_to("dishes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/dishes/1").to route_to("dishes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/dishes/1").to route_to("dishes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/dishes/1").to route_to("dishes#destroy", :id => "1")
    end

  end
end
