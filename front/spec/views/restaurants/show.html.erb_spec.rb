require 'rails_helper'

RSpec.describe "restaurants/show", type: :view do
  before(:each) do
    @restaurant = assign(:restaurant, Restaurant.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
