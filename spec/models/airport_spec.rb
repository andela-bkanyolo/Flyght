require 'rails_helper'

RSpec.describe Airport, type: :model do
  it { is_expected.to validate_presence_of(:code) }
  it { is_expected.to validate_uniqueness_of(:code) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:city) }
  it { is_expected.to validate_presence_of(:country) }
  it { is_expected.to validate_presence_of(:latitude) }
  it { is_expected.to validate_presence_of(:longitude) }

  describe '#formatted' do
    it 'should return a formatted string fo the airport' do
      port = create(:airport)
      list = "#{port.country} - #{port.city} - #{port.name} (#{port.code})"

      expect(port.formatted).to eq list
    end
  end

  describe '.airports_by_geography' do
    it 'should return airports sorted geographically' do
      a = create(:airport, country: 'A')
      b = create(:airport, country: 'B')
      airports = Airport.airports_by_geography

      expect(airports.find_index(a)).to be < airports.find_index(b)
    end
  end
end
