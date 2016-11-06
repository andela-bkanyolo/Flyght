require 'rails_helper'

RSpec.feature 'User Login', js: true do
  before(:all) { @user = create(:user) }

  scenario 'User enters valid login details' do
    login_with(@user.email, @user.password)
    expect(page).to have_content('Sign Out')
    expect(page).to have_content("Welcome back, #{@user.full_name}")
  end

  scenario 'User enters invalid login details' do
    login_with(@user.email, Faker::Lorem.word)
    expect(page).to have_content('Incorrect email or password')
  end
end
