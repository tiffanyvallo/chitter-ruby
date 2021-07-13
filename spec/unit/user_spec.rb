require 'user'

describe User do

  it { is_expected.to be_an_instance_of User}

  context '#all' do
    it 'can list all users' do
      connection = PG.connect(dbname: '')
    end
  end

  # context '#create' do
  #   it 'can create a user and add it to the db' do
  #     User.create(username: 'test1', email: 'test@email.com', password: 'testpassword1')

  #   end
  # end

end