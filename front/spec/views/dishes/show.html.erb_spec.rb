require 'rails_helper'

RSpec.describe "dishes/show", type: :view do
  before(:each) do
    @dish = assign(:dish, Dish.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
