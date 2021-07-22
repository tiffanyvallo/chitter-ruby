# frozen_string_literal: true

require 'peep'
require 'pg'

describe Peep do
  let(:peep) { double(:peep, peep_id: 1, message: 'Test peep', timestamp: '2021-07-19') }
  context '#initialize' do
    it 'should initialize with set attributes' do
      expect(peep.peep_id).to eq(1)
      expect(peep.message).to eq('Test peep')
      expect(peep.timestamp).to eq('2021-07-19')
    end
  end

  context '#.all' do
    it 'can show all the peeps' do
      user = User.create(username: 'test1', email: 'test@email.com', password: 'testpassword1')
      user2 = User.create(username: 'test2', email: 'test2@email.com', password: 'testpassword2')
      Peep.create(user_id: user.id, message: '1st Test Peep!')
      Peep.create(user_id: user2.id, message: 'test peep 2')
      peeps = Peep.all

      expect(peeps.size).to eq(2)
      expect(peeps.last.message).to eq('1st Test Peep!')
      expect(peeps.first.message).to eq('test peep 2')
      expect(peeps.last.user_id).to eq(user.id)
      expect(peeps.first.user_id).to eq(user2.id)
    end
  end

  context '#.create' do
    it 'can create a peep' do
      user = User.create(username: 'test1', email: 'test@email.com', password: 'testpassword1')
      trial = Peep.create(user_id: user.id, message: 'peep testing create')
      expect(trial.user_id).to eq(user.id)
      expect(trial.message).to eq('peep testing create')
      expect(trial.peep_id).not_to be_nil
    end
  end
end
