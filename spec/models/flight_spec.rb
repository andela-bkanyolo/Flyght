require 'rails_helper'

RSpec.describe Flight, type: :model do
  it { is_expected.to validate_presence_of(:origin) }
  it { is_expected.to validate_presence_of(:destination) }
  it { is_expected.to validate_presence_of(:departure) }
  it { is_expected.to validate_presence_of(:distance) }
  it { is_expected.to validate_presence_of(:duration) }
  it { is_expected.to validate_presence_of(:price) }

  it { is_expected.to belong_to(:airline) }
  it { is_expected.to have_many(:bookings) }

  describe 'airports' do
    it 'should be accessible from instance methods' do
      origin_airport = create(:airport)
      departure_airport = create(:airport)
      flight = create(:flight, origin: origin_airport.code,
                               destination: departure_airport.code)

      expect(flight.origin_airport).to eq origin_airport
      expect(flight.destination_airport).to eq departure_airport
    end
  end

  describe 'flight numbers' do
    it 'should return correct flight number' do
      flight = create(:flight)
      number = flight.airline.code + flight.id.to_s

      expect(flight.number).to eq number
    end
  end

  describe 'departure_dates' do
    it 'should return full departure dates' do
      flight = create(:flight)

      expect(flight.departure_date(flight.departure)).to eq flight.departure
    end
  end

  describe 'searching flights' do

    context 'when destination is set' do
      it 'should return flights with correct origin and destination' do
        flight = create(:flight, origin: 'NBO', destination: 'LOS' )
        flight_random = create(:flight)
        results = Flight.from_to("NBO", "LOS")

        expect(results).to include flight
        expect(results).to_not include flight_random
      end
    end

    context 'when destination is not set' do
      it 'should return any flights with that origin' do
        flight = create(:flight, origin: 'NBO', destination: 'LOS' )
        flight_random_destination = create(:flight, origin: 'NBO' )
        flight_random = create(:flight)
        results = Flight.from_to("NBO", "")

        expect(results).to include flight
        expect(results).to include flight_random_destination
        expect(results).to_not include flight_random
      end
    end
  end
end
