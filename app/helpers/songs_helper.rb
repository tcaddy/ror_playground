module SongsHelper

  def song_duration(seconds=nil)
    if seconds and seconds.kind_of?(Fixnum)
      if seconds >= 86400
        "%02d:%02d:%02d:%02d" % [seconds/86400, seconds/3600%24, seconds/60%60, seconds%60]
      elsif seconds >= 3600
        "%02d:%02d:%02d" % [seconds/3600%24, seconds/60%60, seconds%60]
      else
        "%02d:%02d" % [seconds/60%60, seconds%60]
      end
    end
  end
end
