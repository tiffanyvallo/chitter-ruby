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
end