require 'test_helper'

class LoginTest < ActionDispatch::IntegrationTest

  test 'user can log in' do
    visit '/'
    click_button 'Log in'
    assert page.find_button('Log out').visible?
  end

  test 'user can log out' do
    visit '/'
    click_button 'Log in'
    click_button 'Log out'
    assert page.find_button('Log in').visible?
  end

end
