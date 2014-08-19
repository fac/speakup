class Room < ActiveRecord::Base
  has_many :participations
  has_many :users, :through => :participations
  has_many :ratings

  def average_rating
    ratings.average(:score) || 0
  end
end
