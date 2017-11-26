require "rails_helper"

RSpec.describe CustomersController, type: :request do
  describe 'POST /customers' do
    let(:valid_params) { build_customer_params.to_json }

    it do
      post '/customers', params: valid_params, headers: jsonapi_headers
      expect(response).to have_http_status(:created)
      expect(json['data']['id']).not_to be_nil
    end
  end

  describe 'GET /customers' do
    before do
      create :customer
      create :customer
      create :customer
    end

    it do
      get '/customers'
      expect(response).to have_http_status(:ok)
      expect(json['data'].size).to be_eql 3
    end
  end

  describe 'DELETE /customers/id' do
    let(:customer) { create :customer }

    it do
      id = customer.id
      delete "/customers/#{id}"
      expect(response).to have_http_status(:no_content)
      expect(Customer.count).to be_eql 0
    end
  end
end

def build_customer_params
  { data: { type: 'customers', attributes: build_customer_attributes } }
end

def build_customer_attributes
  {
    first_name: 'Bill',
    last_name: 'Gates',
    contact_phone: '123456',
    email: 'johnnash@gmail.com',
    address: 'Sao Paulo',
  }
end
