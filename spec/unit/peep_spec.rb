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
    it 'can show all the peeps' do
      user = User.create(username: 'test1', email: 'test@email.com', password: 'testpassword1')
      user2 = User.create(username: 'test2', email: 'test2@email.com', password: 'testpassword2')
      connection = PG.connect(dbname: 'rubychitter_test')
      test1 = connection.exec("INSERT INTO peeps (user_id, message) VALUES('#{user.id}', '1st Test Peep!');")
      test2 = connection.exec("INSERT INTO peeps (user_id, message) VALUES('#{user2.id}', 'test peep 2');")
      peeps = Peep.all
     
      expect(peeps.size).to eq(2)
      expect(peeps.first.message).to eq('1st Test Peep!')
      expect(peeps.last.message).to eq('test peep 2')
      expect(peeps.first.user_id).to eq(user.id)
      expect(peeps.last.user_id).to eq(user2.id)
    end
  end
end