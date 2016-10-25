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

end
