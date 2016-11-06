require 'rails_helper'

RSpec.describe Booking, type: :model do
  it { is_expected.to belong_to(:flight) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:passengers) }
  it { is_expected.to accept_nested_attributes_for(:passengers) }

  describe 'creation' do
    it 'sets the reference and price on create' do
      booking = create(:booking)

      expect(booking).to validate_presence_of(:reference)
      expect(booking).to validate_presence_of(:price)
      expect(booking).to validate_presence_of(:departure)
      expect(booking).to validate_presence_of(:email)
    end
  end

  describe 'price' do
    it 'depends on number of passengers' do
      booking = create(:booking)
      price = booking.passengers.size * booking.flight.price
      expect(booking.price).to eq price
    end
  end

  describe 'expired' do
    context 'when departure date is past' do
      it 'returns true' do
        booking = create(:booking, departure: Time.now - 1.day)
        expect(booking.expired?).to be true
      end
    end

    context 'when departure date has not reached' do
      it 'returns false' do
        booking = create(:booking, departure: Time.now + 1.day)
        expect(booking.expired?).to be false
      end
    end
  end
end
