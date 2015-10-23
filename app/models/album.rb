require "#{File.expand_path(::Rails.root)}/lib/validations"
class Album < ActiveRecord::Base
  belongs_to :artist
  has_many :songs

  validates :name, presence: true
  validates_with URLValidator, fields: [:photo_url]
  validates_with AlbumYearValidator, fields: [:year]

  def artist_album_name
    "#{self.artist.name} - #{self.name}"
  end
end
