require 'rails_helper'

RSpec.describe "restaurants/edit", type: :view do
  before(:each) do
    @restaurant = assign(:restaurant, Restaurant.create!())
  end

  it "renders the edit restaurant form" do
    render

    assert_select "form[action=?][method=?]", restaurant_path(@restaurant), "post" do
    end
  end
end
