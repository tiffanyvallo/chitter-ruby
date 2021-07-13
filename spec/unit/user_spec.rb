require 'user'
require 'pg'

describe User do

  context '#.all' do
    it 'can list all users' do
      connection = PG.connect(dbname: 'rubychitter_test')
      connection.exec("INSERT INTO users(username,email,password) VALUES('test1', 'test@email.com', 'testpassword1');")
      user = User.all.first
      expect(user.username).to eq 'test1'
      expect(user.email).to eq 'test@email.com'
      expect(user.password).to eq 'testpassword1'
    end
  end
     

  context '#create' do
    it 'can create a user and add it to the db' do
      User.create('test1', 'test@email.com', 'testpassword1')
      user = User.all.first
      expect(user.username).to eq 'test1'
      expect(user.email).to eq 'test@email.com'
      expect(user.password).to eq 'testpassword1'
    end
  end

end