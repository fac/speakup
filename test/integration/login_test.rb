require 'test_helper'

class LoginTest < ActionDispatch::IntegrationTest
  test 'user can log in' do
    visit '/'
    click_button 'Log in'
    assert page.has_content?('Rooms')
    assert page.has_button?('Log out')
  end

  test 'user can log out' do
    visit '/'
    click_button 'Log in'
    click_button 'Log out'

    assert page.has_content?('Rooms')
    assert page.has_button?('Log in')
  end
end
