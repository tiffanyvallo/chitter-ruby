# frozen_string_literal: true

require_relative '../unit/web_helper'

feature 'logout' do
  scenario 'users can log out' do
    signup
    login
    click_button 'Logout'
    expect(page).to have_content('Welcome!')
  end
end
