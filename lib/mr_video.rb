require "mr_video/engine"

module MrVideo

  def self.configure
    yield configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end
  
end
