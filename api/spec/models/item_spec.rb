require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:valid_attributes) do
    { 
      quantity: 12
    }
  end

  let(:invalid_attributes) { {} }

  describe '.create' do
    context 'when valid' do
      let(:order) do 
        customer = create(:customer)
        customer.orders << build(:order)
        customer.orders.first
      end

      let(:dish) do 
        restaurant = create(:restaurant)
        restaurant.dishes << build(:dish) 
        restaurant.dishes.first
      end

      subject do
        described_class.new(valid_attributes).tap do |item|
          item.order = order
          item.dish = dish
          item.save
        end
      end

      it { is_expected.to be_persisted }

      it { is_expected.to be_valid }

      it 'has a quantity' do
        expect(subject.quantity).to eq(valid_attributes[:quantity])
      end
    end

    context 'when invalid' do
      let(:order) do 
        customer = create(:customer)
        customer.orders << build(:order)
        customer.orders.first
      end

      let(:dish) do 
        restaurant = create(:restaurant)
        restaurant.dishes << build(:dish) 
        restaurant.dishes.first
      end

      subject do
        described_class.new(invalid_attributes).tap do |item|
          item.order = order
          item.dish = dish
          item.save
        end
      end

      it { is_expected.not_to be_persisted }

      it { is_expected.not_to be_valid }

      it 'should describe errors' do
        expect(subject.errors).to include(:quantity)
      end
    end
  end
end
