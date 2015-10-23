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