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

  test 'joining room increases participant count' do
    login
    room = Room.new(name: "meeting")
    room.save!
    visit room_path(room)
    assert page.has_content? 'Participants: 0'

    click_button 'Join room'
    assert page.has_content? 'Participants: 1'

    click_button 'Log out'
    visit room_path(room)
    assert page.has_content? 'Participants: 0'
  end

end
