json.array!(@songs) do |song|
  json.extract! song, :id, :album_id, :name, :track, :disk, :duration
  json.url song_url(song, format: :json)
end
