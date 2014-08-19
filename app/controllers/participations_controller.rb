class ParticipationsController < ApplicationController

  def create
    # TODO - don't create a new user each time
    participation = Participation.new(participation_params)
    participation.user = User.new
    if participation.save
      redirect_to room_path(participation.room)
    else
      redirect_to room_path(participation.room)
    end
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def participation_params
    params.require(:participation).permit(:user_id, :room_id)
  end
end
