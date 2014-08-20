require 'test_helper'

class RoomRatingTest < ActionDispatch::IntegrationTest

  setup do
    login
    @room = Room.new(name: "meeting")
    @room.save!
  end

  test 'user can see current room rating' do
    visit room_path(@room)
    assert page.has_content? 'Average score: none'
  end

  test 'defaults score to 3' do
    visit room_path(@room)
    click_button('Join room')
    assert page.has_select?('Rating', :selected => '3')
  end

  test 'once the user has joined room, she can submit ratings' do
    visit room_path(@room)
    click_button('Join room')
    select('2', :from => 'Rating')
    click_button('Submit')
    assert page.has_content? 'Average score: 2'
    assert page.has_select?('Rating', :selected => '2')
    select('5', :from => 'Rating')
    click_button('Submit')
    assert page.has_content? 'Average score: 5'
  end
end
