module SongsHelper

  def song_duration(seconds=nil)
    Song.song_duration seconds
  end
end
