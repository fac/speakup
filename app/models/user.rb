class User < ActiveRecord::Base
  belongs_to :user
  belongs_to :room
  has_many :participations, :dependent => :destroy
  has_many :rooms, :through => :participations

  def in_room?(room)
    rooms.include?(room)
  end
end
