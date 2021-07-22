# frozen_string_literal: true

def signup
  visit '/'
  click_button 'Sign Up'
  fill_in('username', with: 'test1')
  fill_in('email', with: 'test@email.com')
  fill_in('password', with: 'testpassword1')
  click_button('Submit')
end

def login
  fill_in('email', with: 'test@email.com')
  fill_in('password', with: 'testpassword1')
  click_button('Login')
end

def create_peep
  fill_in('message', with: '1st Test Peep!')
  click_button('Post Peep')
end
