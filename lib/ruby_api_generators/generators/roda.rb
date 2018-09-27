require 'thor'

module RubyApiGenerators
  module Generators
    class Roda < Thor::Group
      include Thor::Actions

      argument :name
      class_option :test_framework

      def self.source_root
        File.join(File.dirname(__FILE__), '..', 'templates', 'roda')
      end

      def build_test_suite_folder
        empty_directory "#{name}/spec"
        copy_file 'spec/rspec.options', "#{name}/.rspec"
        template 'spec/spec_helper.rb.erb', "#{name}/spec_helper.rb"
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

      def copy_rakefile
        copy_file 'Rakefile', "#{name}/Rakefile"
      end

      def set_up_application_folder
        build_application_folder
        build_models_folder
        build_routes_folder
        build_config_folder
        build_db_folder
      end

      private

      def build_application_folder
        empty_directory "#{name}/application"
        copy_file 'application/api.rb', "#{name}/application/api.rb"
        copy_file 'application/api/api_support.rb', "#{name}/application/api/api_support.rb"
      end

      def build_config_folder
        empty_directory "#{name}/application/config"
        copy_file 'application/config/database.rb', "#{name}/application/config/database.rb"
        copy_file 'application/config/sequel.rb', "#{name}/application/config/sequel.rb"
      end

      def build_db_folder
        empty_directory "#{name}/application/db"
        copy_file 'application/db/migrations/1_user.rb',
                  "#{name}/application/db/migrations/1_user.rb"
      end

      def build_models_folder
        empty_directory "#{name}/application/models"
        copy_file 'application/api/models/model1.rb', "#{name}/application/models/model1.rb"
      end

      def build_routes_folder
        empty_directory "#{name}/application/routes"
        copy_file 'application/api/routes/main.rb', "#{name}/application/api/routes/main.rb"
      end
    end
  end
end
