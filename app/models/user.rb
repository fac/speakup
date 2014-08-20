class User < ActiveRecord::Base
  belongs_to :user
  belongs_to :room
  has_many :participations, :dependent => :destroy
  has_many :rooms, :through => :participations
  has_many :ratings, :dependent => :destroy

  def in_room?(room)
    rooms.include?(room)
  end

  def rate(room, score)
    Rating.new(user: self, room: room, score: score).save!
  end

  def last_rating_for(room)
    ratings.where(room: room).order(created_at: :desc).first
  end
end
