require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:valid_attributes) do
    { 
      deliver_late: DateTime.now, 
    }
  end

  let(:invalid_attributes) { {} }

  describe '.create' do
    context 'when valid' do
      let(:customer) { create(:customer) }

      subject do
        customer.orders.create(valid_attributes)
      end

      it { is_expected.to be_persisted }

      it { is_expected.to be_valid }

      it 'has a deliver_late' do
        expect(subject.deliver_late).to eq(valid_attributes[:deliver_late])
      end

      it 'has a initial status' do
        expect(subject.status).to eql('initial')
      end
    end

    context 'when invalid' do
      let(:customer) { create(:customer) }

      subject do
        customer.orders.create(invalid_attributes)
      end

      it { is_expected.not_to be_persisted }

      it { is_expected.not_to be_valid }

      it 'should describe errors' do
        expect(subject.errors).to include(:deliver_late)
      end
    end
  end
end
