# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require File.expand_path('../../lib/reset_auto_increment', __FILE__)
require File.expand_path('../../lib/lastfm_api', __FILE__)

# enter names of artists to use for seeding from LastFM
artist_names = ['Rolling Stones','The Beatles','Red Hot Chili Peppers','Phish']

# empty tables and reset auto increments
[Song,Album,Artist].each do |klass|
  klass.send(:delete_all)
  ResetAutoIncrement.reset klass.table_name
end

api = LastfmApi.new
artist_names.each do |artist_name|
  artist = Artist.create! name: artist_name
  begin
    api.last_fm.artist.get_top_albums(artist:artist.name)[0,10].each do |lfm_album|
      album = Album.create! artist:artist,name:lfm_album["name"],photo_url:lfm_album["image"].keep_if{|h| h["size"]=="large"}[0]["content"]
      begin
        album_info = api.last_fm.album.get_info(:mbid=>lfm_album["mbid"])
        album_info["tracks"]["track"].each do |track|
          Song.create! album: album, name: track["name"], duration: track["duration"], track: track["rank"].to_i
        end
      rescue
        puts "error getting album_info for #{artist.name} - #{album.name}"
      end
    end
  rescue Lastfm::ApiError
    puts "error getting artist top albums for: #{artist_name}"
  end
end