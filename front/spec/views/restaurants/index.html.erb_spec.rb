require 'rails_helper'

RSpec.describe "restaurants/index", type: :view do
  before(:each) do
    assign(:restaurants, [
      Restaurant.create!(),
      Restaurant.create!()
    ])
  end

  it "renders a list of restaurants" do
    render
  end
end
