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

      script = RubyApiGenerators::Generators::Roda.new(args, opts_hash)
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

    private

    def opts_hash
      {
        test_framework: options[:test_framework]
      }
    end
  end
end
