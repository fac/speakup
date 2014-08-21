require 'test_helper'

class RoomTest < ActiveSupport::TestCase

  test 'averages ratings' do
    room = create(:room)
    assert_equal nil, room.average_score

    bob = create(:user)
    bob.rate(room, 1)
    assert_equal 1, room.average_score

    alice = create(:user)
    alice.rate(room, 3)
    assert_equal 2, room.average_score
  end

  test 'only takes the last rating from any user' do
    room = create(:room)
    bob = create(:user)
    bob.rate(room, 1)
    bob.rate(room, 5)
    assert_equal 5, room.average_score
  end

end
