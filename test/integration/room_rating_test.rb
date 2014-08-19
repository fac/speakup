require 'test_helper'

class RoomRatingTest < ActionDispatch::IntegrationTest

  test 'user can see current room rating' do
    login
    room = Room.new(name: "meeting")
    room.save!
    visit room_path(room)
    assert page.has_content? 'Average rating: 0'
  end

end
