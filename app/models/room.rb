class Room < ActiveRecord::Base
  has_many :participations
  has_many :users, :through => :participations
  has_many :ratings

  validates :name, :presence => true

  scope :stale, lambda { where("rooms.created_at < ?", 2.days.ago) }

  def average_score
    ratings = self.class.find_by_sql([
      "SELECT t1.score
      FROM ratings AS t1
      LEFT OUTER JOIN ratings AS t2
      ON t1.user_id = t2.user_id
      AND (t1.created_at < t2.created_at
         OR (t1.created_at = t2.created_at AND t1.id < t2.id))
      WHERE t2.user_id IS NULL
      AND t1.user_id IN (?)
      AND t1.room_id = ? ", users.pluck(:id), self.id])

    return nil if ratings.empty?
    ratings.map(&:score).sum.to_f/ratings.length
  end

  def self.average_scores
    Hash[*Room.all.map {|room| [room.id, room.average_score]}.flatten]
  end

  def self.summary
    Hash[*Room.all.map { |room|
           [room.id, {avgScore: room.average_score, participants: room.users.count}]
         }.flatten]
  end
end
