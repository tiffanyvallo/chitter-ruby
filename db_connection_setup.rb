require_relative './lib/database_connection'

if ENV['RACK_ENV'] == 'test'
  DatabaseConnection.setup(dbname: 'rubychitter_test')
else 
  DatabaseConnection.setup(dbname: 'rubychitter')
end