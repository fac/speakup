namespace :speakup do

  desc "Removes old rooms"
  task remove_stale_rooms: :environment do
    Rails.logger.info "Destroying #{Room.stale} stale rooms"
    Room.stale.destroy_all
  end

end
