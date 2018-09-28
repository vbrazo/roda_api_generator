require 'bundler/setup'
require 'ruby_api_generators'

# Add Simplecov configuration
require 'simplecov'
SimpleCov.start do
  add_filter '/.bundle/'
  add_filter '/spec/'
  add_filter '/examples/'
end

# RSpec configuration
RSpec.configure do |config|
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # rubocop:disable Style/EvalWithLocation, Security/Eval
  def capture(stream)
    begin
      stream = stream.to_s
      eval "$#{stream} = StringIO.new"
      yield
      result = eval("$#{stream}").string
    ensure
      eval("$#{stream} = #{stream.upcase}")
    end

    result
  end
  # rubocop:enable Style/EvalWithLocation, Security/Eval
end
