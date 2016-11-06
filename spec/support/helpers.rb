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
end
