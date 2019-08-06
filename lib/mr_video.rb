require 'mr_video/engine'
require 'mr_video/core_ext'

module MrVideo

  def self.configure
    yield configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end
  
end
