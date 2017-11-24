require 'rails_helper'

describe Customer, type: :model do
  let(:valid_attributes) do
    { 
      first_name: 'John', 
      last_name: 'Nash',
      address: 'Floripa', 
      email: 'johnnash@gmail.com'
    }
  end

  let(:invalid_attributes) { {} }

  describe '.create' do
    context 'when valid' do
      subject do
        described_class.create(valid_attributes)
      end

      it { is_expected.to be_persisted }

      it { is_expected.to be_valid }

      it 'has a first name' do
        expect(subject.first_name).to eql(valid_attributes[:first_name])
      end

      it 'has a last name' do
        expect(subject.last_name).to eql(valid_attributes[:last_name])
      end

      it 'has a address' do
        expect(subject.address).to eql(valid_attributes[:address])
      end

      it 'has a email' do
        expect(subject.email).to eql(valid_attributes[:email])
      end
    end

    context 'when invalid' do
      subject do
        described_class.create(invalid_attributes)
      end

      it { is_expected.not_to be_persisted }

      it { is_expected.not_to be_valid }

      it 'should describe errors' do
        expect(subject.errors).to include(:first_name)
        expect(subject.errors).to include(:last_name)
        expect(subject.errors).to include(:address)
        expect(subject.errors).to include(:email)
      end
    end
  end
end
