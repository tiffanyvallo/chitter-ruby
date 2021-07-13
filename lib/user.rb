require 'pg'

class User

  attr_reader :username, :email, :password

  def initialize(username:, email:, password:)
    @username = username
    @email = email
    @password = password
  end

  def self.all
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'rubychitter_test')
    else 
      connection = PG.connect(dbname: 'rubychitter')
    end

    result = connection.exec("SELECT * FROM users;")
    result.map do |user| 
      User.new(username: user['username'], email: user['email'], password: user['password'])
    end
  end

  def self.create(username, email, password)
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'rubychitter_test')
    else 
      connection = PG.connect(dbname: 'rubychitter')
    end

    result = connection.exec("INSERT INTO users(username, email, password) VALUES('#{username}', '#{email}', '#{password}') RETURNING username, email, password;")
    User.new(username: result[0]['username'], email: result[0]['email'], password: result[0]['password'])
  end

end
