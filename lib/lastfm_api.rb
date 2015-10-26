require 'lastfm'
class LastfmApi

  attr_reader :last_fm

  private

  def initialize
    @last_fm = new_last_fm_instance
  end

  def new_last_fm_instance
    fm = Lastfm.new(settings["api_key"], settings["api_secret"])
    fm.session = settings["session_key"]
    fm
  end

  # Last.fm API connection settings. You need to:
  #   1. Create an API application
  #   2. Generate a token and auth URL
  #   3. Visit the auth URL and authorize the app
  #   4. Generate a session_key
  def settings
    fn = File.join(File.expand_path(File.dirname(__FILE__)), '../config/last_fm.yml')
    puts fn
    YAML.load(File.open(fn).read)
  end
end