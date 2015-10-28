class Artist < ActiveRecord::Base
  has_many :albums, dependent: :destroy
  validates :name, presence: true, uniqueness: true

  scope :created_in_last_minute, -> {where("created_at >=?",Time.at(Time.now.to_i-60))}

  def self.seed_artists_from_spotify(artist_names=[])
    artist_names.each do |artist_name|
      if artist = Artist.create(name: artist_name)
        artist.send :seed_from_spotify
      else
        puts "Error creating artist: #{artist_name}"
      end
    end
  end

  private

  def seed_from_spotify
    require 'rspotify'
    return if albums.size>0
    # this should only be run for artists with no albums/songs defined
    sp_artists = RSpotify::Artist.search(name).keep_if{|item| item.name==name}
    if sp_artists.size==1
      self.spotify_id = sp_artists[0].id
      self.save
      sp_artists[0].albums.each do |sp_album|
        opts = {artist_id: id, name: sp_album.name, spotify_id: sp_album.id}
        release_date = sp_album.release_date
        opts[:year] = release_date.to_s.match(/\d{4}/) ? release_date.to_i : Date.parse(release_date).year
        opts[:photo_url] = sp_album.images.sort{|x,y| y["width"]<=>x["width"]}.first["url"] if sp_album.images.size>0
        album = Album.create! opts
        sp_album.tracks.each do |track|
          Song.create! album_id: album.id, name: track.name, duration: (track.duration_ms/1000.0).round, disk: track.disc_number, track: track.track_number, spotify_id: track.id
        end
      end
    elsif sp_artists.size>1
      puts "Error.  #{sp_artists.size} artists found with name: #{name}"
    else
      puts "Error.  No artist found with name: #{name}"
    end
    nil
  end

end
