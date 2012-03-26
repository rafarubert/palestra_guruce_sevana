ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)

require 'rspec/rails'
require 'capybara/rspec'

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

DatabaseCleaner.strategy = :truncation
RSpec.configure do |config|
  config.color_enabled = true
  config.full_backtrace = false
  config.mock_with :rspec
  config.use_transactional_fixtures = false

  config.before(:each) do
    DatabaseCleaner.start
    if example.options[:js]
    end
  end

  config.after(:each) do
    DatabaseCleaner.clean
    if example.options[:js]
    end
  end
end