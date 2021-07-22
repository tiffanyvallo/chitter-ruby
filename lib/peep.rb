require 'pg'
require './db_connection_setup'

class Peep 

  attr_reader :peep_id, :user_id, :message, :timestamp

  def initialize(peep_id:, user_id:, message:, timestamp:)
    @peep_id = peep_id
    @user_id = user_id
    @message = message
    @timestamp = timestamp
  end

  def self.all
    result = DatabaseConnection.query("SELECT * FROM peeps ORDER BY timestamp DESC;")
    result.map do |peep|
    Peep.new(peep_id: peep['peep_id'], 
            user_id: peep['user_id'], 
            message: peep['message'], 
            timestamp: peep['timestamp'])
    end
  end

  def self.create(user_id:, message:)
    result = DatabaseConnection.query("INSERT INTO peeps(user_id, message) 
                                      VALUES('#{user_id}', '#{message}') 
                                      RETURNING peep_id, user_id, message, timestamp;")
    Peep.new(peep_id: result[0]['peep_id'],
            user_id: result[0]['user_id'],
            message: result[0]['message'],
            timestamp: result[0]['timestamp'])
  end

end
