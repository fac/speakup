module RoomsHelper

  def options_for_rating
    (1..5).map { |x| [x,x]}
  end

  def average_score(room)
    if room.average_score
      "%.2f" % room.average_score
    else
      "none"
    end
  end

  def default_rating(rating, room)
    rating || Rating.new(room: room, score: 3)
  end

end
