require 'peep'
require 'pg'

describe Peep do
  let(:peep) { double(:peep, peep_id: 1, message: 'Test peep', timestamp: Date.today )}
  context '#initialize' do
    it 'should initialize with set attributes' do
      expect(peep.peep_id).to eq(1)
      expect(peep.message).to eq('Test peep')
      expect(peep.timestamp).to eq("#{Date.today}")
    end
  end
end