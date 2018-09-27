# frozen_string_literal: true

require 'thor'

# Responsibility: handle the command line interface
module ApiGenerators
  class CLI < Thor
    desc 'roda', 'Generate generic Roda API via CLI'

    option :name, type: :string
    option :test_framework, type: :string, default: :rspec
    
    def roda
      args = [options[:name]]
      opts = {:test_framework => option[:test_framework]}

      script = RubyApiGenerators::Generators::Roda.new(args, opts)
      script.invoke_all
    rescue StandardError => e
      warn "ERROR: #{e.message}"
      exit 1
    end

    desc 'sinatra', 'Generate generic Sinatra API via CLI'
    def sinatra
      # TODO
    rescue StandardError => e
      warn "ERROR: #{e.message}"
      exit 1
    end
  end
end
