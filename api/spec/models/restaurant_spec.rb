require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  let(:valid_attributes) do
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

  let(:invalid_attributes) { {} }

  describe '.create' do
    context 'when valid' do
      subject do
        described_class.create(valid_attributes)
      end

      it { is_expected.to be_persisted }

      it { is_expected.to be_valid }

      it 'has a name' do
        expect(subject.name).to eql(valid_attributes[:name])
      end

      it 'has a contact_name' do
        expect(subject.contact_name).to eql(valid_attributes[:contact_name])
      end

      it 'has a contact_phone' do
        expect(subject.contact_phone).to eql(valid_attributes[:contact_phone])
      end

      it 'has a email' do
        expect(subject.email).to eql(valid_attributes[:email])
      end

      it 'has a address' do
        expect(subject.address).to eql(valid_attributes[:address])
      end

      it 'has a open_at hour' do
        expect(subject.open_at).to eql(valid_attributes[:open_at])
      end

      it 'has a close_at hour' do
        expect(subject.close_at).to eq(valid_attributes[:close_at])
      end

      it 'has a days_of_the_week ' do
        expect(subject.days_of_the_week).to eql(valid_attributes[:days_of_the_week])
      end
    end

    context 'when invalid' do
      subject do
        described_class.create(invalid_attributes)
      end

      it { is_expected.not_to be_persisted }

      it { is_expected.not_to be_valid }

      it 'should describe errors' do
        expect(subject.errors).to include(:name)
        expect(subject.errors).to include(:contact_name)
        expect(subject.errors).to include(:contact_phone)
        expect(subject.errors).to include(:address)
        expect(subject.errors).to include(:email)
        expect(subject.errors).to include(:open_at)
        expect(subject.errors).to include(:close_at)
        expect(subject.errors).to include(:days_of_the_week)
      end
    end
  end
end
