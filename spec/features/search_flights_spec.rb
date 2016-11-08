require 'rails_helper'

RSpec.feature 'Search Flight', js: true do
  before(:all) do
    @origin = create(:airport)
    @destination = create(:airport)
    @flight = create(
      :flight,
      origin: @origin.code,
      destination: @destination.code
    )
  end

  scenario 'User searches for flight' do
    search_flights(@origin.formatted, @destination.formatted, '2017/02/02')
    expect(page).to have_content('1 flight found')
    expect(page).to have_content('SELECT FLIGHT')
    expect(page).to have_content('Book this flight')
  end

  scenario 'User searches for flight with same origin and destination' do
    search_flights(@origin.formatted, @origin.formatted, '2016/02/02')
    expect(page).to have_content(
      'Origin and Destination airport cannot be the same.'
    )
  end

  scenario 'User searches for flight on earlier date than current' do
    search_flights(@origin.formatted, @destination.formatted, '2015/02/02')
    expect(page).to have_content(
      'Date cannot be same as or earlier than current date.'
    )
  end

  scenario 'User searches for flight without specifying date' do
    search_flights(@origin.formatted, @destination.formatted, '')
    expect(page).to have_content(
      'Invalid date entered.'
    )
  end
end
