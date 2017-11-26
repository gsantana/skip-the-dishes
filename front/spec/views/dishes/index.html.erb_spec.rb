require 'rails_helper'

RSpec.describe "dishes/index", type: :view do
  before(:each) do
    assign(:dishes, [
      Dish.create!(),
      Dish.create!()
    ])
  end

  it "renders a list of dishes" do
    render
  end
end
