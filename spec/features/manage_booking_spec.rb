require 'rails_helper'

RSpec.feature 'Manage Booking', js: true do
  before(:all) do
    origin = create(:airport)
    destination = create(:airport)
    flight = create(:flight, origin: origin.code, destination: destination.code)
    @booking = create(:booking, flight_id: flight.id)
    @invalid_booking = build(:booking)
  end

  scenario 'User clicks on Manage Booking' do
    visit root_path
    click_on 'Manage Booking'
    expect(page).to have_content('Confirmation Number')
    expect(page).to have_content('SEARCH')
  end

  scenario 'User enters valid confirmation number' do
    visit find_bookings_path
    fill_in 'ref', with: @booking.reference
    click_button 'Search'
    expect(page).to have_content('Booking found')
    expect(page).to have_content("Confirmation Number: #{@booking.reference}")
  end

  scenario 'User enters invalid confirmation number' do
    visit find_bookings_path
    fill_in 'ref', with: @invalid_booking.reference
    click_button 'Search'
    expect(page).to have_content('Booking was not found')
  end
end
