module Helpers
  def stub_current_user(user)
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(user)
  end

  def login_with(email, password)
    visit login_path
    fill_in 'session_email', with: email
    fill_in 'session_password', with: password
    click_on 'Log in'
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
