# Configure Rails Envinronment
ENV['RAILS_ENV'] = 'test'

require 'spec_helper'
require File.expand_path('../dummy/config/environment.rb',  __FILE__)
require 'rspec/collection_matchers'
require 'rspec/its'
require 'rspec/rails'
require 'shoulda/matchers'

ENGINE_RAILS_ROOT=File.join(File.dirname(__FILE__), '../')

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.join(ENGINE_RAILS_ROOT, 'spec/support/**/*.rb')].each {|f| require f }

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec do |c|
    c.syntax = [:should, :expect]
  end

  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  #config.fixture_path = '#{::Rails.root}/spec/fixtures'

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
  
  # in RSpec 3 this will no longer be necessary (used with VCR gem).
  # config.treat_symbols_as_metadata_keys_with_true_values = true

  # Includes:
  config.include MrVideo::Engine.routes.url_helpers

  # Hooks:
  config.before(:each) do
    MrVideo.configuration.stub(:cassette_library_dir).and_return('spec/fixtures/vcr_cassettes')
  end

  config.before(:each) do
  end

  config.after(:each) do
  end

end
