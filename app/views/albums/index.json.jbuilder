json.array!(@albums) do |album|
  json.extract! album, :id, :artist_id, :name, :year, :photo_url
  json.url album_url(album, format: :json)
end
