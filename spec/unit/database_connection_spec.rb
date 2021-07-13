require 'database_connection'

describe DatabaseConnection do
  
  context '#.setup' do
    it 'can set up the db' do
      expect(PG).to receive(:connect).with(dbname: 'rubychitter_test')
      DatabaseConnection.setup('rubychitter_test') 
    end
  end

  context '#.connection' do
    it 'can connect and stay connected' do
      connection = DatabaseConnection.setup('rubychitter_test')
      expect(DatabaseConnection.connection).to eq connection
    end
  end

  context '#.query' do
    it 'can respond to the db query' do
      connection = DatabaseConnection.setup('rubychitter_test')
      expect(connection).to receive(:exec).with("SELECT * FROM users")
      DatabaseConnection.query("SELECT * FROM users;")
    end
  end
end