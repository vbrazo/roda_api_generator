# Load path and gems/bundler
$LOAD_PATH << __dir__

require 'bundler'
require 'logger'
Bundler.require

require 'dotenv'
Dotenv.load

file_path = File.dirname(__FILE__)

%w(config middlewares api/db api/models).each do |path|
  Dir["#{file_path}/#{path}/**/*.rb"].each { |file| require file }
end

require './application/api/api_support'
