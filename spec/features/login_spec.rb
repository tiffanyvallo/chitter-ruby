# frozen_string_literal: true
require_relative '../unit/web_helper'

feature 'login' do
  scenario 'user can log into account' do
    signup
    fill_in('email', with: 'test@email.com')
    fill_in('password', with: 'testpassword1')
    click_button 'Login'
    expect(page).to have_content("Here's what's happening: ")
  end
end