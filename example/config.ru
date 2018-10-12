require './application/api'

run Rack::Cascade.new [ApiSupport]
