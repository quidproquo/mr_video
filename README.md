Mr. Video [![Build Status](https://travis-ci.org/quidproquo/mr_video.png?branch=master)](http://travis-ci.org/quidproquo/mr_video) [![Code Climate](https://codeclimate.com/github/quidproquo/mr_video.png)](https://codeclimate.com/github/quidproquo/mr_video) [![Coverage Status](https://coveralls.io/repos/quidproquo/mr_video/badge.png?branch=master)](https://coveralls.io/r/quidproquo/mr_video?branch=master)
======

Rails-based front-end for the popular [VCR gem](https://github.com/vcr/vcr). It allows you to
browse cassettes and episodes. HTTP body content from episodes can be viewed in the browser,
enabling easy debugging of JSON and HTML. Furthermore, cassettes and episodes can be deleted,
allowing for easy maintenance of recorded content. While Mr. Video is mainly meant to be used
in your development environment, it can be configured for production and is not directly
dependent on the VCR gem.

Compatibility
-------------

Mr. Video is tested against MRI 2.3.0. For Ruby <= 2.3.0, use version 1.0.5.

Installation
------------

Mr. Video is a Rails Engine and is primarily meant to be used in your development
environment.

Add it to your `Gemfile`.

```ruby
# Gemfile

group :development do
  gem 'mr_video'
end
```

Configure the location of your VCR cassettes directory.

```ruby
# config/initializers/mr_video.rb

if Rails.env.development? && defined?(MrVideo)
  MrVideo.configure do |config|
    config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  end
end
```

Mount it in your `config/routes.rb`.

```ruby
# config/routes.rb

MyApp::Application.routes.draw do

  if Rails.env.development?
    require 'mr_video'
    mount MrVideo::Engine => '/mr_video'
  end

end
```

Stand-alone
------------

For non Rails projects, you can create a single file that embeds everything, create in `mr_video.rb`:


```ruby
begin
  require "bundler/inline"
rescue LoadError => e
  $stderr.puts "Bundler version 1.10 or later is required. Please update your Bundler"
  raise e
end

gemfile(true) do
  source "https://rubygems.org"

  gem "rails", "~> 6.1.3"
  gem "puma", "~> 5.2.2"
  gem "mr_video"
  gem "sprockets", "<4" # Recent Sprockets requires a manifest file
end

require 'action_controller/railtie'
require 'sprockets/railtie'
require 'mr_video'

class App < Rails::Application
  routes.append do
    mount MrVideo::Engine => "/mr_video"

    # ActionDispatch requires a defined root_path
    root to: proc {|env| [301, {"Location" => "/mr_video"}, ["Redirect"]] }
  end

  config.consider_all_requests_local = true
end

MrVideo.configure do |config|
  # Overwrite with cassettes directory in your project
  config.cassette_library_dir = "spec/cassettes"
end

App.initialize!

Rack::Server.new(app: App, Port: 3000).start
```

And run it like:
```bash
ruby mr_video.rb
```

Copyright
---------

Copyright &copy; 2014 Ilya Scharrenbroich. Released under the MIT License.


