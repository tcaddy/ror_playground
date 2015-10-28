require 'uri'
# validates a URL
class URLValidator < ActiveModel::Validator
  def validate(record)
    options[:fields].each do |field|
      if (url = record.send(field)) && url != ''
        err = false
        begin
          uri = URI.parse(url)
          unless uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
            err = true
          end
        rescue URI::InvalidURIError
          err = true
        end
        record.errors.add(field, 'invalid URL format') if err
      end
    end
  end
end

# validates a suitable year for an album, allowing nil/blank values
# (:validates_numericality_of doesn't like nil values)
class AlbumYearValidator < ActiveModel::Validator
  def validate(record)
    options[:fields].each do |field|
      if (year = record.send(field)) && year != ''
        unless year.is_a?(Fixnum) && year >= 1900 && year <= Time.zone.today.year + 1
          record.errors.add(field, 'is not a valid year')
        end
      end
    end
  end
end

# validates a suitable track number for a song, allowing nil/blank values
# (:validates_numericality_of doesn't like nil values)
class TrackNumberValidator < ActiveModel::Validator
  def validate(record)
    options[:fields].each do |field|
      if (track = record.send(field)) && track != ''
        unless track.is_a?(Fixnum) && (track < 100 || track > 0)
          record.errors.add(field, "is not a valid #{field} number")
        end
      end
    end
  end
end
