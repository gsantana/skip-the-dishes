require 'rails_helper'

RSpec.describe RestaurantsController, type: :request do
  describe 'POST /restaurants' do
    let(:valid_params) { build_restaurant_params.to_json }

    it do
      post '/restaurants', params: valid_params, headers: jsonapi_headers
      expect(response).to have_http_status(:created)
      expect(json['data']['id']).not_to be_nil
    end
  end

  describe 'GET /restaurants' do
    before do
      create :restaurant
      create :restaurant
      create :restaurant
    end

    it do
      get '/restaurants'
      expect(response).to have_http_status(:ok)
      expect(json['data'].size).to be_eql 3
    end
  end

  describe 'DELETE /restaurant/id' do
    let(:restaurant) { create :restaurant }

    it do
      id = restaurant.id
      delete "/restaurants/#{id}"
      expect(response).to have_http_status(:no_content)
      expect(Restaurant.count).to be_eql 0
    end
  end
end

def build_restaurant_params
  { data: { type: 'restaurants', attributes: build_restaurant_attributes } }
end

def build_restaurant_attributes
  {
    name: 'Good Food',
    contact_name: 'Bill Gates',
    contact_phone: '123456',
    email: 'johnnash@gmail.com',
    address: 'Sao Paulo',
    open_at: 5.hours.ago,
    close_at: DateTime.now,
    days_of_the_week: 2
  }
end
