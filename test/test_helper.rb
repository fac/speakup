ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'capybara/rails'
require 'capybara/poltergeist'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  include FactoryGirl::Syntax::Methods
  # Add more helper methods to be used by all tests here...

  setup do
    FactoryGirl.lint
  end
end

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL

  self.use_transactional_fixtures = false

  setup do
    Capybara.default_wait_time = 5
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

  def login
    visit '/'
    click_button 'Log in'
  end
end
