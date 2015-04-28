ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/pride"
require "database_cleaner"

DatabaseCleaner.strategy = :truncation

class ActiveSupport::TestCase
  def teardown
    DatabaseCleaner.clean
  end
end
