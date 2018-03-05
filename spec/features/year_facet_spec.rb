require 'rails_helper'

RSpec.feature 'Year Facet' do
  let(:title) { ['Apothecary jar. Label: Pom: Pice N:'] }
  let(:archival_collection) { ['Duke Medical Center Library & Archives'] }
  let(:date) { ['1973-04-09','1970-1979'] }
  let(:date_created) { ['2018-02-05'] }
  let(:subject) { ['Apothecary jar', 'Apothecary', 'Medicine', 'Ceramic', 'Jar, covered', 'Porcelain', 'Apothecaries'] }
  let(:description) { ['Apothecary jar. 19th century. France. Porcelain. Label: Pom: Pice N: Handpainted scene of lions, scrolls and foliage. Marked "L. Caut, Paris, 30 Rue des Francs Bourgeant."'] }
  let(:holding_entity) { ['Medicl Center Archives'] }
  let(:host_organization) { ['Medical Library Association'] }
  let(:visibility) { Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC }
  let :doc do
    Document.new(title: title,
                 archival_collection: archival_collection,
                 holding_entity: holding_entity,
                 date: date,
                 date_created: date_created,
                 subject: subject,
                 description: description,
                 host_organization: host_organization,
                 visibility: visibility)
  end

  scenario "Show a Document to an unauthenticated user" do
    doc.save
    visit("/catalog")
    expect(page).to have_css "#facet-year_iim"
    range_min = page.find('#facet-year_iim .range.subsection .min').text.to_i
    range_max = page.find('#facet-year_iim .range.subsection .max').text.to_i
    expect(range_min).to be <= 1970
    expect(range_max).to be >= 1979
  end

end
