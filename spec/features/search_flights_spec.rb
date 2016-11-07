require 'rails_helper'

RSpec.feature 'Sign Up', js: true do
  before(:all) do
    @origin = create(:airport)
    @destination = create(:airport)
    @flight = create(:flight,
                     origin: @origin.code, destination: @destination.code)
  end

  after(:all) do
    @origin.destroy
    @destination.destroy
    @flight.destroy
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

  def search_flights(origin, destination, date)
    visit root_path
    find_all('div.select-wrapper input').first.click
    #sleep(0.3)
    find('div.select-wrapper li', text: origin).click
    page.execute_script 'window.scrollBy(0,-10000)'
    find_all('div.select-wrapper input')[1].click
    #sleep(0.3)
    find('div.select-wrapper li', text: destination).click
    page.execute_script 'window.scrollBy(0,-10000)'
    find_all('div.select-wrapper input')[2].click
    #sleep(0.3)
    find('div.select-wrapper li', text: '1').click
    fill_in 'date', with: date
    click_button 'search'
  end
end
