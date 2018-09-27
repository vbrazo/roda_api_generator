require 'dotenv'
Dotenv.load

require 'sequel'
require_relative './application/config/database.rb'

namespace :bundler do
  task :setup do
    require 'rubygems'
    require 'bundler/setup'
  end
end

task :environment, [:env] => 'bundler:setup' do |_cmd, args|
  ENV['RACK_ENV'] = args[:env] || 'development'
end

namespace :db do
  desc 'Run database migrations'
  task :migrate, :env do |_cmd, args|
    env = args[:env] || 'development'
    Rake::Task['environment'].invoke(env)

    require 'sequel/extensions/migration'
    Sequel::Migrator.apply(DB, 'application/db/migrations')
  end

  desc 'Drop the database'
  task :drop, :env do |_cmd, args|
    env = args[:env] || 'development'
    Rake::Task['environment'].invoke(env)

    DB.tables.each do |table|
      DB.run("DROP TABLE #{table}")
    end
  end

  desc 'Reset the database'
  task :reset, [:env] => %i[drop migrate]
end
