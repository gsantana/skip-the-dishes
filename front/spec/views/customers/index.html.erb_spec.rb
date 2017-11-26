require 'rails_helper'

RSpec.describe "customers/index", type: :view do
  before(:each) do
    assign(:customers, [
      Customer.create!(),
      Customer.create!()
    ])
  end

  it "renders a list of customers" do
    render
  end
end
