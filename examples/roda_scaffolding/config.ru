require './application/api'

use RackAuthMiddleware
run Rack::Cascade.new [ApiSupport]
