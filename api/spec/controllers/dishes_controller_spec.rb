require "rails_helper"

RSpec.describe DishesController, type: :request do
  describe 'POST /dishes' do
    let(:valid_params) { build_dishes_params }
    let(:restaurant) { create :restaurant }

    it do
      post '/dishes', params: valid_params, headers: jsonapi_headers
      expect(response).to have_http_status(:created)
      expect(json['data']['id']).not_to be_nil
    end
  end

  describe 'GET /dishes' do
    let(:restaurant) { create :restaurant }
    let(:dish1) { create :dish, restaurant: restaurant }
    let(:dish2) { create :dish, restaurant: restaurant }
    let(:dish3) { create :dish, restaurant: restaurant }

    before do
      restaurant.dishes = [dish1, dish2, dish3]
    end

    it do
      id = restaurant.id
      get '/dishes'
      expect(response).to have_http_status(:ok)
      expect(json['data'].size).to be_eql 3
    end
  end

  describe 'DELETE /dishes/id' do
    let(:restaurant) { create :restaurant }
    let(:dish) { create :dish, restaurant: restaurant }

    before do
      restaurant.dishes = [ dish ]
    end

    it do
      id = restaurant.id
      dish_id = dish.id
      delete "/dishes/#{dish_id}"
      expect(response).to have_http_status(:no_content)
      restaurant.reload
      expect(restaurant.dishes).to be_empty
    end
  end
end

def build_dishes_params
  {
    data: {
      type: 'dishes',
      attributes: build_dishes_attributes,
      relationships: build_restaurant_relationship
    }
  }.to_json
end

def build_dishes_attributes
  {
    name: 'Rice and Beans',
    price: 10.00,
    calories: 100
  }
end

def build_restaurant_relationship
  {
    restaurant: { data: { type: 'restaurants', id: restaurant.id } }
  }
end
