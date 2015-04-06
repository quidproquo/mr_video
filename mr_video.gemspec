$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version and other constants:
require 'mr_video/constants'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'mr_video'
  s.version     = MrVideo::VERSION
  s.authors     = ['Ilya Scharrenbroich']
  s.email       = ['ilya.j.s@gmail.com']
  s.homepage    = MrVideo::URL
  s.summary     = 'Rails-based front-end for the popular VCR gem.'
  s.description = 'Rails-based front-end for the popular VCR gem. It allows you to browse cassettes and episodes. HTTP body content from episodes can be viewed in the browser, enabling easy debugging of JSON and HTML.'

  s.files = Dir['{app,config,db,lib}/**/*'] + ['MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['spec/**/*']

  s.add_dependency 'rails', '>= 4.0.0'
end