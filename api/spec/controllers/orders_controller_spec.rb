require "rails_helper"

RSpec.describe OrdersController, type: :request do

  describe 'POST create' do
    let(:customer) { create :customer }

    let(:valid_params) do
      { data: { type: 'orders', attributes: { deliver_late: Time.now },
                relationships: { customer:
                          { data: { type: 'customers', id: customer.id } } } } }
        .to_json
    end

    let(:headers) do
      {
        'CONTENT-TYPE' => 'application/vnd.api+json',
        'ACCEPT' => 'application/vnd.api+json'
      }
    end

    context 'on success' do
      it do
        post '/orders', params: valid_params, headers: headers
        json = JSON.parse(response.body)
        expect(response).to have_http_status(:created)
      end
    end
  end
end
