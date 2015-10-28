require File.expand_path('../controller_macros', __FILE__)
RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
  config.extend ControllerMacros, type: :controller
end
