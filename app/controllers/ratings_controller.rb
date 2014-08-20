class RatingsController < ApplicationController

  def create
    @rating = Rating.new(rating_params)
    @rating.user = current_user
    if @rating.save
      redirect_to @rating.room
    else
      redirect_to @rating.room
    end
  end

  def rating_params
    params.require(:rating).permit(:name, :score, :room_id)
  end
end
