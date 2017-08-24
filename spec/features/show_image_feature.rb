require 'rails_helper'

RSpec.feature 'Display an Image' do
  let(:title) { ['Apothecary jar. Label: Pom: Pice N:'] }
  let(:archival_collection) { ['Eugene Stead papers'] }
  let(:date) { ['1973-04-09'] }
  let(:holding_entity) { ['Medical Center Archives'] }
  let(:date_accepted) { ['April 9, 1973'] }
  let(:condition) { ['lid broken'] }
  let(:accrual_method) { ['Donation'] }
  let(:provenance) { ['Found at Yard Sale'] }
  let(:based_near) { ['Room 201'] }
  let(:visibility) { Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC }
  let :image do
    Image.new(title: title, based_near: based_near, archival_collection: archival_collection, holding_entity: holding_entity, date_accepted: date_accepted, date: date, condition: condition, provenance: provenance, accrual_method: accrual_method, visibility: visibility)
  end

  context 'a logged in user' do
    let(:user_attributes) do
      { email: 'test@example.com' }
    end
    let(:user) do
      User.new(user_attributes) { |u| u.save(validate: false) }
    end

    before do
      image.save
    end

    scenario " to logged in user" do
      login_as user
      visit("/concern/images/#{image.id}")
      expect(page).to have_content image.title.first
      expect(page).to have_content image.archival_collection.first
      expect(page).to have_content image.date.first
      expect(page).to have_content image.holding_entity.first
      expect(page).to have_content image.date_accepted.first
      expect(page).to have_content image.condition.first
      expect(page).to have_content image.accrual_method.first
      expect(page).to have_content image.provenance.first
    end

#    scenario "Show an Image unauthenticated user" do
#      visit("/concern/images/#{image.id}")
#      expect(page).to have_content "Library Location"
#      expect(page).to have_content image.title.first
#      expect(page).to have_content image.archival_collection.first
#      expect(page).not_to have_content image.date.first
#      expect(page).to have_content image.holding_entity.first
#      expect(page).not_to have_content image.date_accepted.first
#      expect(page).not_to have_content image.condition.first
#      expect(page).not_to have_content image.accrual_method.first
#      expect(page).not_to have_content image.provenance.first
#    end

  end
end
