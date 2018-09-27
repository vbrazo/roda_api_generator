class RackAuthMiddleware
  UnprocessableHeader = Class.new(ArgumentError)

  def initialize(app, options = {})
    @app = app
    @options = options
  end

  # TODO: Finish middleware
  def call(env)
    _token, _options = *token_and_options(env['HTTP_AUTHORIZATION'])

    @app.call(env)
  rescue UnprocessableHeader
    unprocessable_header_app.call(env)
  end

  def unprocessable_header_app
    @options.fetch(:unprocessable_header_app) { default_unprocessable_header_app }
  end

  def default_unprocessable_header_app
    ->(_env) { Rack::Response.new('Unprocessable Authorization header', 400) }
  end

  def token_and_options(header)
    token = header.to_s.match(/^token (.*)/) { |m| m[1] }
    if token
      begin
        values = Hash[token.split(',').map do |value|
          value.strip!                      # remove any spaces between commas and values
          key, value = value.split(/\=\"?/) # split key=value pairs
          value.chomp!('"')                 # chomp trailing " in value
          value.gsub!(/\\\"/, '"')          # unescape remaining quotes
          [key, value]
        end]
        [values.delete('token'), values]
      rescue StandardError => error
        raise UnprocessableHeader, error
      end
    else
      [nil, {}]
    end
  end
end
