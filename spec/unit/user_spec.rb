# frozen_string_literal: true

require 'user'
require 'pg'

describe User do
  context '#.all' do
    it 'can list all users' do
      10.times { |x| User.create(username: "test#{x}", email: "test#{x}@email.com", password: 'testpassword1') }
      user = User.all
      expect(user.first.username).to eq 'test0'
      expect(user.first.email).to eq 'test0@email.com'
      expect(user.length).to eq(10)
    end
  end

  context '#create' do
    it 'can create a user and add it to the db' do
      User.create(username: 'test1', email: 'test@email.com', password: 'testpassword1')
      user = User.all.first
      expect(user.username).to eq 'test1'
      expect(user.email).to eq 'test@email.com'
      expect(user.id).not_to be_nil
    end
    it 'can encrypt the password when created' do
      expect(BCrypt::Password).to receive(:create).with('testpassword1')
      User.create(username: 'test2', email: 'test@email.com', password: 'testpassword1')
    end
  end

  context '#.find' do
    it 'can find a user from the db with the given email address' do
      user = User.create(username: 'test1', email: 'test@email.com', password: 'testpassword1')
      find = User.find(column: 'id', value: user.id)
      expect(find.username).to eq('test1')
    end
    it 'return nil if no email mathches found' do
      expect(User.find(column: 'id', value: nil)).to eq nil
    end
    it 'returns nil if no matches found' do
      expect(User.find(column: 'id', value: 7)).to eq nil
    end
  end

  context '#.authenticate' do
    it 'can return the correct user when email and password match' do
      user = User.create(username: 'test1', email: 'test@email.com', password: 'testpassword1')
      authenticated_user = User.authenticate('test@email.com', 'testpassword1')
      expect(user.email).to eq(authenticated_user.email)
    end
  end
end
