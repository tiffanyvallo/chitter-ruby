require_relative '../unit/web_helper'

feature 'Can view peeps' do
  scenario 'user can view peeps in the feed' do
    signup
    login
    fill_in('message', with: '1st Test Peep!')
    click_button('Post a Peep')
    expect(page).to have_content("1st Test Peep!")
  end
end