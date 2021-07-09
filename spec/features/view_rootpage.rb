# frozen_string_literal: true

feature 'view root page' do
  scenario 'visiting the root page' do
    visit('/')
    expect(page).to have_content('Chitter')
  end
end
