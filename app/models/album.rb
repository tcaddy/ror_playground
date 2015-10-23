require "#{File.expand_path(::Rails.root)}/lib/validations"
class Album < ActiveRecord::Base
  belongs_to :artist
  validates :name, presence: true
  validates_with URLValidator, fields: [:photo_url]
  validates_with AlbumYearValidator, fields: [:year]
end
