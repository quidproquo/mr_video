Mr. Video [![Build Status](https://travis-ci.org/quidproquo/mr_video.png?branch=master)](http://travis-ci.org/quidproquo/mr_video) [![Code Climate](https://codeclimate.com/github/quidproquo/mr_video.png)](https://codeclimate.com/github/quidproquo/mr_video) [![Coverage Status](https://coveralls.io/repos/quidproquo/mr_video/badge.png?branch=master)](https://coveralls.io/r/quidproquo/mr_video?branch=master)
======

Rails-based front-end for the popular [VCR gem](https://github.com/vcr/vcr). It allows you to
browse cassettes and episodes. HTTP body content from episodes can be viewed in the browser,
enabling easy debugging of JSON and HTML. Furthermore, cassettes and eposides can be deleted, 
allowing for easy maintenance of recorded content. While Mr. Video is mainly meant to be used 
in your development environment, it can be configured for production and is not directly 
dependent on the VCR gem.

Compatibility
-------------

Mr. Video is tested against MRI (1.9.3+).

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

Copyright
---------

Copyright &copy; 2014 Ilya Scharrenbroich. Released under the MIT License.


