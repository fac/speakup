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

end
