require "#{File.expand_path(::Rails.root)}/lib/validations"
# Song model
class Song < ActiveRecord::Base
  belongs_to :album

  validates :name, :track, presence: true
  validates :track, numericality: { only_integer: true }
  validates_with TrackNumberValidator, fields: [:track, :disk]

  def self.parse_duration(value = nil)
    return nil if value.nil?
    return value if value.is_a?(Fixnum)
    sum = 0
    if value.is_a?(String) && value.match(/\d\d?:\d\d/)
      value.split(':').reverse.each_with_index do |item, i|
        multiplier =
          case i
          when 0
            1
          when 1
            60
          when 2
            3_600
          else 1
          end
        sum += multiplier * item.to_i
      end
    end
    sum
  end

  def self.song_duration(seconds = nil)
    if seconds && seconds.is_a?(Fixnum)
      if seconds >= 86_400
        format '%02d:%02d:%02d:%02d', seconds / 86_400, seconds / 3_600 % 24, seconds / 60 % 60, seconds % 60
      elsif seconds >= 3600
        format '%02d:%02d:%02d', seconds / 3_600 % 24, seconds / 60 % 60, seconds % 60
      else
        format '%02d:%02d', seconds / 60 % 60, seconds % 60
      end
    end
  end
end
