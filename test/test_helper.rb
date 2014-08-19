ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'capybara/rails'
require 'capybara/poltergeist'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL

  self.use_transactional_fixtures = false

  setup do
    Capybara.current_driver = :poltergeist
    DatabaseCleaner.strategy = :deletion
    DatabaseCleaner.start
  end

  teardown do
    Capybara.reset_sessions!
    DatabaseCleaner.clean
  end

  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, :phantomjs_logger => STDOUT)
  end
end
