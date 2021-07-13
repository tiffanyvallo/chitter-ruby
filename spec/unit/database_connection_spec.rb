require 'database_connection'

describe DatabaseConnection do
  
  context '#.setup' do
    it 'can set up the db' do
      expect(PG).to receive(:connect).with(dbname: 'rubychitter_test')
      DatabaseConnection.setup('rubychitter_test') 
    end
  end
  
end