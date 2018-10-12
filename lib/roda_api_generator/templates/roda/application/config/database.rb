# Sequel Configuration
DB = Sequel.connect(ENV.fetch('DATABASE_ENV'))
