require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }

  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_confirmation_of(:password) }
  it { is_expected.to validate_length_of(:password).is_at_least(6) }
  it { is_expected.to validate_presence_of(:password_confirmation) }

  it { is_expected.to have_secure_password }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to validate_length_of(:email).is_at_most(255) }

  it { is_expected.to have_many(:bookings) }

  describe '.full name' do
    it 'should return formatted full name' do
      user = create(:user, first_name: "ben", last_name: "kanyolo")

      expect(user.full_name).to eq "Ben Kanyolo"
    end
  end
end
