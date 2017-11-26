require 'rails_helper'

RSpec.describe "restaurants/new", type: :view do
  before(:each) do
    assign(:restaurant, Restaurant.new())
  end

  it "renders new restaurant form" do
    render

    assert_select "form[action=?][method=?]", restaurants_path, "post" do
    end
  end
end
