require 'rails_helper'

RSpec.describe Dish, type: :model do
  let(:valid_attributes) do
    { 
      name: 'Good',
      price: 10.25
    }
  end

  let(:invalid_attributes) { {} }

  describe '.create' do
    context 'when valid' do
      let(:restaurant) { create(:restaurant) }

      subject do
        restaurant.dishes.create(valid_attributes)
      end

      it { is_expected.to be_persisted }

      it { is_expected.to be_valid }

      it 'has a name' do
        expect(subject.name).to eq(valid_attributes[:name])
      end

      it 'has a price' do
        expect(subject.price).to eql(valid_attributes[:price])
      end
    end

    context 'when invalid' do
      let(:restaurant) { create(:restaurant) }

      subject do
        restaurant.dishes.create(invalid_attributes)
      end

      it { is_expected.not_to be_persisted }

      it { is_expected.not_to be_valid }

      it 'should describe errors' do
        expect(subject.errors).to include(:name)
        expect(subject.errors).to include(:price)
      end
    end
  end
end
