require "#{File.expand_path(::Rails.root)}/lib/validations"
class Song < ActiveRecord::Base
  belongs_to :album

  validates :name, :track, presence: true
  validates :track, numericality: { only_integer: true }
  validates_with TrackNumberValidator, fields: [:track,:disk]

  def self.parse_duration(value=nil)
    return nil if value.nil?
    return value if value.kind_of?(Fixnum)
    sum = 0
    if value.kind_of?(String) and value.match(/\d\d?:\d\d/)
      value.split(":").reverse.each_with_index do |item,i|
        multiplier = case i
          when 0
            1
          when 1
            60
          when 2
            3600
          else 1
        end
        sum += multiplier * item.to_i
      end
    end
    sum
  end
end
