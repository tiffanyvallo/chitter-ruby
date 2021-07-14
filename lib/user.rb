# frozen_string_literal: true

require 'pg'
require './db_connection_setup'
require 'bcrypt'

class User
  attr_reader :username, :email, :password

  def initialize(username:, email:)
    @username = username
    @email = email
  end

  def self.all
    result = DatabaseConnection.query('SELECT * FROM users;')
    result.map do |user|
      User.new(username: user['username'], email: user['email'])
    end
  end

  def self.create(username, email, password)
    encrypted_password = BCrypt::Password.create(password)
    result = DatabaseConnection.query("INSERT INTO users(username, email, password)
                                        VALUES('#{username}', '#{email}', '#{encrypted_password}')
                                        RETURNING username, email;")
    User.new(username: result[0]['username'],
             email: result[0]['email'])
  end

  def self.find(email)
    result = DatabaseConnection.query("SELECT * FROM users WHERE email = '#{email}';")
    return unless result.any?
    User.new(username: result[0]['username'],
      email: result[0]['email'])
  end

end
