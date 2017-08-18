require 'rails_helper'

RSpec.feature 'Display an Image' do
  let(:title) { ['Apothecary jar. Label: Pom: Pice N:'] }
  let(:holding_entity) { ['Duke Medical Center Library & Archives']}
  let(:identifier) { ['hcaldwell0034']}
  #let(:creator) { ['Eun, Dongwon'] }
  #let(:keyword) { ['China', 'Minority Population'] }
  let(:visibility) { Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC }
  let :image do
    Image.new(title: title, holding_entity: holding_entity, identifier: identifier, visibility: visibility)
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

    scenario "Show an Image to logged in user" do
      login_as user
      visit("/concern/images/#{image.id}")
      expect(page).to have_content image.title.first
      expect(page).to have_content image.holding_entity.first
      # add expected fields here that you expect to see if you are logged in
      expect(page).to have_content image.identifier.first
    end

    scenario "Show an Image unauthenticated user" do
      visit("/concern/images/#{image.id}")
      expect(page).to have_content image.title.first
      expect(page).to have_content image.holding_entity.first
      expect(page).not_to have_content image.identifier.first
    end

  end
end
