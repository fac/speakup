class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.references :user
      t.references :room

      t.string :name
      t.integer :score

      t.timestamps
    end
  end
end
