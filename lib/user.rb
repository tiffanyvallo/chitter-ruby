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
end
