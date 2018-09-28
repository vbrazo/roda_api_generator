class ApiSupport < Roda
  use Rack::Session::Cookie, key: ENV['RACK_COOKIE_KEY'], secret: ENV['RACK_COOKIE_SECRET']
  use Rack::Protection
  use Rack::Protection::RemoteReferrer

  plugin :environments
  plugin :json
  plugin :json_parser

  self.environment = ENV['ENVIRONMENT']

  require_relative './routes/main.rb'
end
