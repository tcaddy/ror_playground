class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.integer :album_id
      t.string :name
      t.integer :track
      t.integer :disk
      t.integer :duration

      t.timestamps null: false
    end
  end
end
