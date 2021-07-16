# frozen_string_literal: true
require_relative '../unit/web_helper'

feature 'Can view peeps' do
  scenario 'user can view peeps in the feed' do
    signup
    login
    expect(page).to have_content("1st Test Peep!")
  end
end