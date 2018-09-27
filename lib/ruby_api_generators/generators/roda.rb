require 'thor'

module RubyApiGenerators
  module Generators
    class Roda < Thor::Group
      include Thor::Actions

      # Define arguments and options
      argument :name
      class_option :test_framework

      def self.source_root
        File.join(File.dirname(__FILE__), '..', 'templates', 'roda')
      end

      def copy_gemfile
        copy_file 'Gemfile', "#{name}/Gemfile"
      end

      def copy_licence
        copy_file 'LICENSE', "#{name}/LICENSE"
      end

      def copy_readme
        copy_file 'README.md', "#{name}/README.md"
      end

      def copy_config_ru
        copy_file 'config.ru', "#{name}/config.ru"
      end
    end
  end
end
