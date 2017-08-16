require 'rails_helper'

RSpec.feature 'Display an Image' do
  let(:title) { ['Apothecary jar. Label: Pom: Pice N:'] }
  let(:holding_entity) { ['Duke Medical Center Library & Archives']}
  #let(:creator) { ['Eun, Dongwon'] }
  #let(:keyword) { ['China', 'Minority Population'] }
  let(:visibility) { Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC }
  let :image do
    Image.new(title: title, holding_entity: holding_entity, visibility: visibility)
  end

  context 'a logged in user' do
    let(:user_attributes) do
      { email: 'test@example.com' }
    end
    let(:user) do
      User.new(user_attributes) { |u| u.save(validate: false) }
    end

    before do
      login_as user
      image.save
    end

    scenario "Show an Image" do
      visit("/concern/images/#{image.id}")
      expect(page).to have_content image.title.first
      expect(page).to have_content image.holding_entity.first
    end
  end
end
