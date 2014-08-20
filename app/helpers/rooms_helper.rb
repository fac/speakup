module RoomsHelper

  def options_for_rating
    (1..5).map { |x| [x,x]}
  end

end
