namespace :db do
  desc 'Performs migration up to latest migration available'
  task :migrate do
    Sequel.extension :migration, :core_extensions
    Sequel::Migrator.run(DB, 'application/db/migrations')
  end

  desc 'Generates a new timestamped Sequel migration'
  task :migration, :name do |_, args|
    if args[:name].nil?
      puts 'Please specify a name for your migration (e.g. rake generate:migration[add_user_table])'
      exit false
    end

    timestamp = Time.now.utc.strftime('%Y%m%d%H%M%S')
    filename = File.join('application/db/migrations', "#{timestamp}_#{args[:name]}.rb")

    require 'fileutils'
    FileUtils.cp_r('application/db/migrations/migration_template.rb', filename)

    puts "Created the migration #{filename}"
  end

  desc 'Drop all database tables and re-run migrations'
  task :reset do
    DB.tables.each { |table| DB.drop_table(table.to_sym) }

    Rake::Task['db:migrate'].execute
  end
end
