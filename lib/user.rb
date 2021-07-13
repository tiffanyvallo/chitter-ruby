require 'pg'
require './db_connection_setup'

class User

  attr_reader :username, :email, :password

  def initialize(username:, email:, password:)
    @username = username
    @email = email
    @password = password
  end

  def self.all
    result = DatabaseConnection.query("SELECT * FROM users;")
    result.map do |user| 
      User.new(username: user['username'], email: user['email'], password: user['password'])
    end
  end

  def self.create(username, email, password)
    result = DatabaseConnection.query("INSERT INTO users(username, email, password) 
                                        VALUES('#{username}', '#{email}', '#{password}') 
                                        RETURNING username, email, password;")
    User.new(username: result[0]['username'], 
            email: result[0]['email'], 
            password: result[0]['password'])
  end

end
