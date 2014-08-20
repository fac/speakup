class ParticipationsController < ApplicationController

  def create
    participation = Participation.new(participation_params)
    participation.user = current_user
    if participation.save
      redirect_to room_path(participation.room)
    else
      redirect_to room_path(participation.room)
    end
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def participation_params
    params.require(:participation).permit(:room_id)
  end
end
