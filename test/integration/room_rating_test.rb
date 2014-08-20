require 'test_helper'

class RoomRatingTest < ActionDispatch::IntegrationTest

  setup do
    login
    @room = Room.new(name: "meeting")
    @room.save!
  end

  test 'user can see current room rating' do
    visit room_path(@room)
    assert page.has_content? 'Average rating: none'
  end

  test 'once the user has joined room, she can submit rating' do
    visit room_path(@room)
    click_button('Join room')
    select('2', :from => 'rating_score')
    click_button('Submit')
    assert page.has_content? 'Average rating: 2'
  end

end
