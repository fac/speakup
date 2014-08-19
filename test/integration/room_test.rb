require 'test_helper'

class RoomTest < ActionDispatch::IntegrationTest

  test 'creating new room' do
    visit '/'
    click_link 'New Room'
    assert page.has_content? 'New room'
    fill_in('Name', :with => 'Test room')
    click_button('Create Room')
    assert page.has_content? 'Test room'
  end

end
