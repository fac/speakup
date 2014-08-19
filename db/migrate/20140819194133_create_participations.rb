class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.references :user
      t.references :room
      t.timestamps
    end
  end
end
