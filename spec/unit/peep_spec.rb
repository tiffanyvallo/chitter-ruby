require 'peep'
require 'pg'

describe Peep do
  let(:peep) { double(:peep, peep_id: 1, message: 'Test peep', timestamp: '2021-07-19')}
  context '#initialize' do
    it 'should initialize with set attributes' do
      expect(peep.peep_id).to eq(1)
      expect(peep.message).to eq('Test peep')
      expect(peep.timestamp).to eq('2021-07-19')
    end
  end

  context '#.all' do
    it 'can show all the pepps' do
      connection = PG.connect(db: 'rubychitter_test')
      connection.exec("INSERT INTO peeps (message.timestamp) VALUES('test peep 1', '2021-07-19');")
      connection.exec("INSERT INTO peeps (message.timestamp) VALUES('test peep 2', '2021-07-20');")
      peep = Peep.all
      expect(peep.first.message).to eq('test peep 1')
      expect(peep.first.timestamp).to eq('2021-07-19')
    end
  end
end