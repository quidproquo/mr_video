module MrVideo

  class MrVideoController < ActionController::Base
    begin
      skip_forgery_protection
    rescue
      # ignored
    end

    layout 'mr_video'

  end

end # MrVideo module