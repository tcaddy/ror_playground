class AddSpotifyIdToTables < ActiveRecord::Migration
  def change
    [:artists, :albums, :songs].each do |table|
      change_table table do |t|
        t.string :spotify_id
      end
    end
  end
end
