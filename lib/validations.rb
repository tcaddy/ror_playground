# validates a URL
require 'uri'
class URLValidator < ActiveModel::Validator
  def validate(record)
    options[:fields].each do |field|
      if url = record.send(field)
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

# validates a suitable year for an album, allowing nil values
# (:validates_numericality_of doesn't like nil values)
class AlbumYearValidator < ActiveModel::Validator
  def validate(record)
    options[:fields].each do |field|
      if year = record.send(field)
        unless year.kind_of?(Fixnum) or year<1900 or year>Date.today.year+1
          record.errors.add(attr, 'is not a valid year')
        end
      end
    end
  end
end