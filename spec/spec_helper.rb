# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'webmock/rspec'
# WebMock.disable_net_connect!(allow_localhost: true)

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
  
  # Stubbing web service requests to SF Data and Google places in order to 
  # speed up tests and from reaching API limits
  config.before(:each) do
    
    # stub web service request to SF data for filming location info
    films_file_path = Rails.root.join('spec', 'support', 'fixtures', 'sf_films.json').to_s
    stub_request(:get, /.*data.sfgov.org\/resource\/yitu-d5am.json.*/).
      to_return(:status => 200, :body => File.open(films_file_path).read, :headers => {'Content-Type' => 'application/json'})
    
    # stub web service request to google places for resolving location data
    resolved_locations_file_path = Rails.root.join('spec', 'support', 'fixtures', 'resolved_locations.json').to_s
    stub_request(:get, /.*maps.googleapis.com\/maps\/api\/place\/nearbysearch\/json.*/).
      to_return(:status => 200, :body => File.open(resolved_locations_file_path).read, :headers => {'Content-Type' => 'application/json'})
  
  end
end
