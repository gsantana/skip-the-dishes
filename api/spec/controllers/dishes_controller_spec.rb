require "rails_helper"

RSpec.describe DishesController, type: :request do
  describe 'POST' do
    let(:valid_params) { build_params.to_json }

    let(:restaurant) { create :restaurant }

    it do
      id = restaurant.id
      post "/restaurants/#{id}/dishes", params: valid_params, headers: jsonapi_headers
      expect(response).to have_http_status(:created)
      expect(json['data']['id']).not_to be_nil
    end
  end
end

def build_params
  { data: { type: 'dishes',
            attributes: build_attributes,
            relationships: build_relations } }
end

def build_attributes
  {
    name: 'Rice and Beans',
    price: 10.00,
    calories: 100
  }
end

def build_relations
  {
    restaurant: { data: { type: 'restaurants', id: restaurant.id } }
  }
end
