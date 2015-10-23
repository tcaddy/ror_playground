# validates a URL
require 'uri'
class URLValidator < ActiveModel::Validator
  def validate(record)
    options[:fields].each do |field|
      if url = record.send(field) and url != ''
        err = false
        begin
          uri = URI.parse(url)
          unless uri.kind_of?(URI::HTTP) or uri.kind_of?(URI::HTTPS)
            err = true
          end
        rescue URI::InvalidURIError
          err = true
        end
        if err
          record.errors.add(field, 'invalid URL format')
        end
      end
    end
  end
end

# validates a suitable year for an album, allowing nil/blank values
# (:validates_numericality_of doesn't like nil values)
class AlbumYearValidator < ActiveModel::Validator
  def validate(record)
    options[:fields].each do |field|
      if year = record.send(field) and year != ''
        unless year.kind_of?(Fixnum) and year>=1900 and year<=Date.today.year+1
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
      if track = record.send(field) and track != ''
        unless track.kind_of?(Fixnum) and track<100 or track>0
          record.errors.add(field, "is not a valid #{field} number")
        end
      end
    end
  end
end