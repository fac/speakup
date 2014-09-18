class ParticipationsController < ApplicationController

  def create
    participation = Participation.new(participation_params)
    participation.user = current_user
    if participation.save
      redirect_to room_path(participation.room)
    else
      redirect_to room_path(participation.room)
    end
    WebsocketClients.instance.push('room_data', Room.summary)
  end

  def destroy
    participation = Participation.find(params[:id])
    participation.destroy
    redirect_to room_path(participation.room)
    WebsocketClients.instance.push('room_data', Room.summary)
  end

  def participation_params
    params.require(:participation).permit(:room_id)
  end
end
