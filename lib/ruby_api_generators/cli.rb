# frozen_string_literal: true

require 'thor'

# Responsibility: handle the command line interface
module ApiGenerators
  class CLI < Thor
    desc 'cuba', 'Generate generic Cuba API via CLI'
    def cuba
      # TODO
    rescue StandardError => e
      warn "ERROR: #{e.message}"
      exit 1
    end

    desc 'grape', 'Generate generic Grape API via CLI'
    option :name, type: :string

    def grape
      args = [options[:name] || 'test_app']

      script = RubyApiGenerators::Generators::Grape.new(args)
      script.invoke_all
    rescue StandardError => e
      warn "ERROR: #{e.message}"
      exit 1
    end

    desc 'roda', 'Generate generic Roda API via CLI'
    option :name, type: :string

    def roda
      args = [options[:name] || 'test_app']

      script = RubyApiGenerators::Generators::Roda.new(args)
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
