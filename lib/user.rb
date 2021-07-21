# frozen_string_literal: true

require 'pg'
require './db_connection_setup'
require 'bcrypt'

class User
  attr_reader :id, :username, :email, :password

  def initialize(id:, username:, email:)
    @id = id
    @username = username
    @email = email
  end

  def self.all
    result = DatabaseConnection.query('SELECT * FROM users;')
    result.map do |user|
      User.new(id: user['id'], username: user['username'], email: user['email'])
    end
  end

  def self.create(username:, email:, password:)
    encrypted_password = BCrypt::Password.create(password)
    result = DatabaseConnection.query("INSERT INTO users(username, email, password)
                                        VALUES('#{username}', '#{email}', '#{encrypted_password}')
                                        RETURNING id, username, email;")
    User.new(id: result[0]['id'],
            username: result[0]['username'],
            email: result[0]['email'])
  end

  def self.find(column:, value:)
    return unless ['id', 'email'].include? column
    return unless value
    result = DatabaseConnection.query("SELECT * FROM users WHERE #{column} = '#{value}';")
    return if result.count() == 0
    User.new(id: result[0]['id'],
      username: result[0]['username'],
      email: result[0]['email'])
  end

  def self.authenticate(email, password)
    result = DatabaseConnection.query("SELECT * FROM users WHERE email = '#{email}';")
    return unless result.any?
    return unless BCrypt::Password.new(result[0]['password']) == password
    User.new(id: result[0]['id'],
      username: result[0]['username'],
      email: result[0]['email'])
  end

end
