require 'rails_helper'

RSpec.feature 'Sign Up', js: true do
  before(:all) do
    @user = build(:user)
    @registered = create(:user)
  end

  after(:all) do
    @user.destroy
    @registered.destroy
  end

  scenario 'User clicks on Sign Up' do
    visit root_path
    click_on 'Sign Up'
    expect(page).to have_content('Sign Up')
    expect(page).to have_content('First Name')
    expect(page).to have_content('Last Name')
    expect(page).to have_content('Email')
  end

  scenario 'User signs up with valid details' do
    signup(@user.first_name, @user.last_name, @user.email, @user.password,
           @user.password_confirmation)
    expect(page).to have_content('Sign Out')
    expect(page).to have_content("Welcome #{@user.full_name}")
  end

  scenario 'User enters a used email' do
    signup(@user.first_name, @user.last_name, @registered.email, @user.password,
           @user.password_confirmation)
    expect(page).to have_content('Email has already been taken')
  end

  scenario 'User enters no data at all' do
    signup('', '', '', '', '')
    expect(page).to have_content('8 errors found')
    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("Last name can't be blank")
    expect(page).to have_content("Password can't be blank")
    expect(page).to have_content(
      'Password is too short (minimum is 6 characters)'
    )
    expect(page).to have_content("Password confirmation doesn't match Password")
    expect(page).to have_content("Password confirmation can't be blank")
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content('Email is invalid')
  end

  def signup(first_name, last_name, email, password, password_confirmation)
    visit signup_path
    fill_in 'user_first_name', with: first_name
    fill_in 'user_last_name', with: last_name
    fill_in 'user_email', with: email
    fill_in 'user_password', with: password
    fill_in 'user_password_confirmation', with: password_confirmation
    click_button 'Sign Up'
  end
end
