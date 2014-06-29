require 'mr_video/constants'
require 'mr_video/configuration'

module MrVideo

  class Engine < ::Rails::Engine
    isolate_namespace MrVideo

    config.generators do |g|
      g.test_framework :rspec, :view_specs => false
    end

  end

end