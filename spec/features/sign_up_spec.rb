feature 'sign up' do
  scenario 'user can sign up and get a confirmation' do
    visit '/'
    click_button 'Sign Up'
    fill_in('username', with: 'test1')
    fill_in('email', with: 'test@email.com')
    fill_in('password', with: 'testpassword1')
    click_button 'Submit'
    expect(page).to have_content('Welcome test1!')
  end
end