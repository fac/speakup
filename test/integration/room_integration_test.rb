require 'test_helper'

class RoomIntegrationTest < ActionDispatch::IntegrationTest

  test 'creating new room' do
    login
    visit '/'
    click_link 'New Room'
    assert page.has_content? 'New room'
    fill_in('Name', :with => 'Test room')
    click_button('Create Room')
    assert page.has_content? 'Test room'
  end

  test 'can return to lobby' do
    login
    visit '/'
    click_link 'New Room'
    click_link 'Lobby'
    assert page.has_content? 'Lobby'
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

  test 'joining room hides "Join room" button' do
    login
    room = Room.new(name: "meeting")
    room.save!
    visit room_path(room)
    click_button 'Join room'
    assert page.has_no_button?('Join room')
  end

end
