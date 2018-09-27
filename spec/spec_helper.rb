require 'bundler/setup'
require 'ruby_api_generators'

# Add Simplecov configuration
require 'simplecov'
SimpleCov.start do
  add_filter '/.bundle/'
  add_filter '/spec/'
end

# RSpec configuration
RSpec.configure do |config|
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
