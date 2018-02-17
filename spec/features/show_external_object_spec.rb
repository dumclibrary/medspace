require 'rails_helper'

RSpec.feature 'Display an External Object' do
  let(:title) { ['Apothecary jar. Label: Pom: Pice N:'] }
  let(:archival_collection) { ['Duke Medical Center Library & Archives'] }
  let(:related_url) { ['http://archives.mc.duke.edu']}
  let(:date) { ['1973-04-09'] }
  let(:date_created) { ['2018-02-05'] }
  let(:subject) { ['Apothecary jar', 'Apothecary', 'Medicine', 'Ceramic', 'Jar, covered', 'Porcelain', 'Apothecaries'] }
  let(:description) { ['Apothecary jar. 19th century. France. Porcelain. Label: Pom: Pice N: Handpainted scene of lions, scrolls and foliage. Marked "L. Caut, Paris, 30 Rue des Francs Bourgeant."'] }
  let(:holding_entity) { ['Medicl Center Archives'] }
  let(:visibility) { Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC }
  let :exo do
    ExternalObject.new(title: title,
              archival_collection: archival_collection,
              related_url: related_url,
              holding_entity: holding_entity,
              date: date,
              date_created: date_created,
              subject: subject,
              description: description,
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
      exo.save
    end

    scenario "Show an External Object to logged in user" do
      login_as user
      visit("/concern/external_objects/#{exo.id}")
      expect(page).to have_content exo.title.first
      # expect(page).to have_link href: "#{exo.related_url.first}"
      expect(page).to have_content exo.archival_collection.first
      expect(page).to have_content exo.date.first
      expect(page).to have_content exo.holding_entity.first
    end

    scenario "Show an External Object unauthenticated user" do
      visit("/concern/external_objects/#{exo.id}")
      expect(page).to have_content exo.title.first
      # expect(page).to have_link href: "#{exo.related_url.first}"
      expect(page).to have_content exo.archival_collection.first
      expect(page).not_to have_content exo.date.first
      expect(page).to have_content exo.holding_entity.first
    end
  end
end
