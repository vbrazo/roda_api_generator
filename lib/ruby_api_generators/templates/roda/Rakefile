require 'dotenv'
Dotenv.load

$LOAD_PATH.unshift(File.expand_path('./application'))
current_task = Rake.application.top_level_tasks.first

require 'bundler'
require 'bundler/setup'

if current_task['db:']
  require 'config/sequel'
  require 'config/database'
end

Dir['./application/tasks/**/*.rake'].each { |rake_file| import(rake_file) }
