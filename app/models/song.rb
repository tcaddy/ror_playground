require "#{File.expand_path(::Rails.root)}/lib/validations"
class Song < ActiveRecord::Base
  belongs_to :album

  validates :name, :track, presence: true
  validates :track, numericality: { only_integer: true }
  validates_with TrackNumberValidator, fields: [:track,:disk]
end
