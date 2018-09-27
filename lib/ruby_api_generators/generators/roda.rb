require 'thor'

module RubyApiGenerators
  module Generators
    class Roda < Thor::Group
      include Thor::Actions

      # Define arguments and options
      argument :name
      class_option :test_framework

      def self.source_root
        File.join(File.dirname(__FILE__), '..', 'templates')
      end

      def create_test_file
        extension = options[:test_framework] == 'rspec' ? :spec : :test

        create_file "#{name}/#{extension}/#{name}_#{extension}.rb"
      end
    end
  end
end
