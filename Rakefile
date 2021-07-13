require 'pg'

task :setup do
  p 'Creating databases...'

  %w[rubychitter rubychitter_test].each do |database|
    connection = PG.connect
    connection.exec("CREATE DATABASE #{database};")
    connection = PG.connect(dbname: database)

    connection.exec("CREATE TABLE users (id SERIAL PRIMARY KEY,
      username VARCHAR (50),
      email VARCHAR (50) UNIQUE,
      password VARCHAR (100)
    );")

    connection.exec("CREATE TABLE peeps (peep_id SERIAL PRIMARY KEY,
      user_id INT,
      FOREIGN KEY (user_id) REFERENCES users (id),
      message VARCHAR(100),
      timestamp TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
    );")

  end
end