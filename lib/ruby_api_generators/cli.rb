# frozen_string_literal: true

require 'thor'

# Responsibility: handle the command line interface
module ApiGenerators
  class CLI < Thor
    desc 'api_generators roda', 'Generate generic Roda API via CLI'
    # CLI method to generate generic roda API
    def roda
      # TODO
    rescue StandardError => e
      warn "ERROR: #{e.message}"
      exit 1
    end

    desc 'api_generators sinatra', 'Generate generic Sinatra API via CLI'
    # CLI method to generate generic sinatra API
    def sinatra
      # TODO
    rescue StandardError => e
      warn "ERROR: #{e.message}"
      exit 1
    end
  end
end
