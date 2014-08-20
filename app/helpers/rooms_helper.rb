module RoomsHelper

  def options_for_rating
    (1..5).map { |x| [x,x]}
  end

  def average_rating(room)
    if room.average_rating
      "%.2f" % room.average_rating
    else
      "none"
    end
  end

  def default_rating(rating, room)
    rating || Rating.new(room: room, score: 3)
  end

end
