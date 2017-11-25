require "rails_helper"

RSpec.describe OrdersController, type: :request do

  describe 'POST create' do
    let(:customer) { create :customer }
    let(:restaurant) { create :restaurant }
    let(:dish) do
      restaurant.dishes << build(:dish)
      restaurant.dishes.first
    end

    let(:item) do 
      item = build :item 
      item.dish = dish
      item.save
      item
    end
    let(:valid_params) do
      {
      	data: {
      		type: 'orders',
      		attributes: {
      			deliver_late: Time.now
      		},
      		relationships: {
      			customer: {
      				data: {
      					type: 'customers',
      					id: customer.id
      				}
      			},
            items: {
              data: [
                {
                  type: "items",
                  attributes: {
                    quantity: 10,
                  },
                  relationships: {
                    dish: {
                      type: 'dishes',
                      id: dish.id
                    }
                  }
                }
              ]
            }
      		}
      	}
      }.to_json
    end

    let(:headers) do
      {
        'CONTENT-TYPE' => 'application/vnd.api+json',
        'ACCEPT' => 'application/vnd.api+json'
      }
    end

    context 'when succeed' do
      it do
        post '/orders', params: valid_params, headers: headers
        expect(response).to have_http_status(:created)
        json = JSON.parse(response.body)
        expect(json['data']['type']).to be_eql 'orders'
      end
    end

    context 'when invalid' do
      let(:invalid_param) do
        { data: { type: 'orders', attributes: {} } }.to_json
      end

      it do
        post '/orders', params: invalid_param, headers: headers
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json['errors']).not_to be_empty
      end
    end
  end
end
