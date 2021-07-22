require_relative '../unit/web_helper'

feature 'peeps in reverse chronological' do
  scenario 'users can see peeps in reverse chronological order' do
    signup
    login
    create_peep
    fill_in('message', with: '2nd Test Peep!')
    click_button('Post Peep')
    first_index = page.body.index('2nd Test Peep')
    second_index = page.body.index('1st Test Peep!')
    expect(first_index).to be < second_index
  end
end