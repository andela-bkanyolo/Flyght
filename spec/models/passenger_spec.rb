require 'rails_helper'

RSpec.describe Passenger, type: :model do
  it { is_expected.to belong_to(:booking) }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :passport }

  it { is_expected.to validate_presence_of :age }
  it 'validate numericalitys' do
    should validate_numericality_of(:age).is_greater_than_or_equal_to(0)
  end
  it { is_expected.to validate_presence_of :age }
end
