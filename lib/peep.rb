# frozen_string_literal: true

require 'pg'
require './db_connection_setup'

class Peep
  attr_reader :peep_id, :username, :message, :timestamp

  def initialize(peep_id:, username:, message:, timestamp:)
    @peep_id = peep_id
    @username = username
    @message = message
    @timestamp = timestamp
  end

  def self.all
    result = DatabaseConnection.query('SELECT * FROM peeps ORDER BY timestamp DESC;')
    result.map do |peep|
      Peep.new(peep_id: peep['peep_id'],
               username: peep['username'],
               message: peep['message'],
               timestamp: peep['timestamp'])
    end
  end

  def self.create(username:, message:)
    result = DatabaseConnection.query("INSERT INTO peeps(username, message)
                                      VALUES('#{username}', '#{message}')
                                      RETURNING peep_id, username, message, timestamp;")
    Peep.new(peep_id: result[0]['peep_id'],
             username: result[0]['username'],
             message: result[0]['message'],
             timestamp: result[0]['timestamp'])
  end
end
