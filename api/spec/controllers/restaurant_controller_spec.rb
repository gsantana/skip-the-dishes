require 'rails_helper'

RSpec.describe RestaurantsController, type: :request do
  describe 'POST' do
    let(:valid_params) { build_params.to_json }

    it do
      post '/restaurants', params: valid_params, headers: jsonapi_headers
      expect(response).to have_http_status(:created)
      expect(json['data']['id']).not_to be_nil
    end
  end
end

def build_params
  { data: { type: 'restaurants', attributes: build_attributes } }
end

def build_attributes
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
