class Peep 

  attr_reader :peep_id, :user_id, :message, :timestamp

  def initialize(peep_id:, user_id:, message:, timestamp:)
    @peep_id = peep_id
    @user_id = user_id
    @message = message
    @timestamp = timestamp
  end

  def self.all
    result = DatabaseConnection.query('SELECT * FROM peeps;')
    result.map do |peep|
    Peep.new(peep_id: peep['peep_id'], user_id: peep['user_id'], message: peep['message'], timestamp: peep['timestamp'])
    end
  end

end
