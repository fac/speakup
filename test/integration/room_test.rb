require 'test_helper'

class RoomTest < ActionDispatch::IntegrationTest

  test 'creating new room' do
    visit '/'
    click_link 'New Room'
    assert page.has_content? 'New room'
  end

end
