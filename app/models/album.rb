require "#{File.expand_path(::Rails.root)}/lib/validations"
# Album model
class Album < ActiveRecord::Base
  belongs_to :artist
  has_many :songs, dependent: :destroy

  validates :name, presence: true
  validates_with URLValidator, fields: [:photo_url]
  validates_with AlbumYearValidator, fields: [:year]

  scope :for_select, -> { joins('inner join artists on albums.artist_id=artists.id').select('albums.*,artists.name as artist_name').order('artist_name,name') }

  def artist_album_name
    "#{artist.name} - #{name}"
  end
end
