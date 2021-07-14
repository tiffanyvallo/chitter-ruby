def signup
  visit '/'
  click_button 'Sign Up'
  fill_in('username', with: 'test1')
  fill_in('email', with: 'test@email.com')
  fill_in('password', with: 'testpassword1')
  click_button 'Submit'
end
