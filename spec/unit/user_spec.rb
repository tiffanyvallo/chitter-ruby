# frozen_string_literal: true

require 'user'
require 'pg'

describe User do
  context '#.all' do
    it 'can list all users' do
      PG.connect(dbname: 'rubychitter_test')
      10.times { |x| User.create('test1', "test#{x}@email.com", 'testpassword1') }
      user = User.all
      expect(user.first.username).to eq 'test1'
      expect(user.first.email).to eq 'test0@email.com'
      
    end
  end

  context '#create' do
    it 'can create a user and add it to the db' do
      User.create('test1', 'test@email.com', 'testpassword1')
      user = User.all.first
      expect(user.username).to eq 'test1'
      expect(user.email).to eq 'test@email.com'
     
    end
    it 'can encrypt the password when created' do
      expect(BCrypt::Password).to receive(:create).with('testpassword1')
      User.create('test1', 'test@email.com', 'testpassword1')
    end
  end

  context '#.find' do
    it 'can find a user from the db with the given email address' do
      User.create('test1', 'test@email.com', 'testpassword1')
      user = User.find('test@email.com')
      expect(user.username).to eq('test1')
    end
    it 'return nil if no email mathches found' do
      expect(User.find('test@email.com')).to eq(nil)
    end
  end
end
