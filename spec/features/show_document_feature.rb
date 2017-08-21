require 'rails_helper'

RSpec.feature 'Display an Image' do
  let(:title) { ['Apothecary jar. Label: Pom: Pice N:'] }
  let(:archival_collection) { ['Duke Medical Center Library & Archives'] }
  let(:date) { ['1973-04-09'] }
  let(:holding_entity) { ['Medicl Center Archives'] }
  let(:host_organization) { ['Medical Library Association'] }
  let(:visibility) { Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC }
  let :doc do
    Document.new(title: title,
              archival_collection: archival_collection,
              holding_entity: holding_entity,
              date: date,
              host_organization: host_organization,
              visibility: visibility)
  end

  context 'a logged in user' do
    let(:user_attributes) do
      { email: 'test@example.com' }
    end
    let(:user) do
      User.new(user_attributes) { |u| u.save(validate: false) }
    end

    before do
      doc.save
    end

    scenario "Show a Document to logged in user" do
      login_as user
      visit("/concern/documents/#{doc.id}")
      expect(page).to have_content doc.title.first
      expect(page).to have_content doc.archival_collection.first
      expect(page).to have_content doc.date.first
      expect(page).to have_content doc.host_organization.first
      expect(page).to have_content doc.holding_entity.first
    end

    scenario "Show a Document to an unauthenticated user" do
      visit("/concern/documents/#{doc.id}")
      expect(page).to have_content doc.title.first
      expect(page).to have_content doc.archival_collection.first
      expect(page).not_to have_content doc.date.first
      expect(page).to have_content doc.host_organization.first
      expect(page).to have_content doc.holding_entity.first
    end
  end
end
