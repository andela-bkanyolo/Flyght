require 'rails_helper'

RSpec.feature 'Sign Up', js: true do
  before(:all) do
    @user = create(:user)
    @origin = create(:airport)
    @destination = create(:airport)
    @flight = create(:flight,
                     origin: @origin.code, destination: @destination.code)
  end

  after(:all) do
    @origin.destroy
    @destination.destroy
    @flight.bookings.destroy_all
    @flight.destroy
    @user.destroy
  end

  scenario 'User searches for flight and selects it for booking' do
    search_to_book
    expect(page).to have_content("You've chosen to book the below flight.")
  end

  scenario 'User completes a full booking process' do
    search_to_book
    fill_in_booking_details(@user.email, @user.full_name, 23, 'B1234', '421528')
    expect(page).to have_content('Your booking was successfully created.')
  end

  scenario 'User completes a full booking process with invalid data' do
    search_to_book
    fill_in_booking_details('', '', '', '', '')
    expect(page).to have_content('6 errors found:')
    expect(page).to have_content("Passengers name can't be blank")
    expect(page).to have_content("Passengers passport can't be blank")
    expect(page).to have_content("Passengers age can't be blank")
    expect(page).to have_content('Passengers age is not a number')
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content('Email is invalid')
  end

  scenario 'Registered user completes a full booking process' do
    login_with(@user.email, @user.password)
    search_to_book
    fill_in_booking_details(nil, @user.full_name, 23, 'B1234', '421528')
    visit(bookings_user_path(@user))
    expect(page).to have_content('Here are your past bookings')
    expect(page).to have_content(@flight.origin_airport.name)
    expect(page).to have_content(@flight.destination_airport.name)
  end

  def fill_in_booking_details(email, name, age, passport, phone)
    fill_in 'booking_email', with: email if email
    fill_in 'booking_passengers_attributes_0_name', with: name
    fill_in 'booking_passengers_attributes_0_age', with: age
    fill_in 'booking_passengers_attributes_0_passport', with: passport
    fill_in 'booking_passengers_attributes_0_phone', with: phone
    click_on('search')
  end

  def search_to_book
    search_flights(@origin.formatted, @destination.formatted, '2017/02/02')
    find_by_id(@flight.id).click
    click_on('select')
  end
end
