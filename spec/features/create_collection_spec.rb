require 'rails_helper'
include Warden::Test::Helpers

# NOTE: If you generated more than one work, you have to set "js: true"
RSpec.feature 'Create a collection', js: false do
  context 'a logged in user' do
    let(:user_attributes) do
      { email: 'test@example.com' }
    end
    let(:user) do
      User.new(user_attributes) { |u| u.save(validate: false) }
    end

    before do
      login_as user
    end

    scenario do
      visit '/dashboard/collections/new'
      expect(page).to_not have_content 'Additional fields'
      # fill_in 'Title', with: 'This is a new collection'
      # fill_in 'Creator', with: 'Adonna Thompson'
      # click_on('Create Collection')
      # expect(page).to have_content 'This is a new collection'
      # expect(page).to have_content 'Adonna Thompson'
    end
  end
end
