class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.integer :artist_id
      t.string :name
      t.integer :year
      t.string :photo_url

      t.timestamps null: false
    end
  end
end
