# Generated via
#  `rails generate hyrax:work Image`
require 'rails_helper'

RSpec.describe Hyrax::ImagePresenter do
  subject { presenter }

  let(:title) { ['Apothecary jar. Label: Pom: Pice N:'] }
  let(:archival_collection) { ['Duke Medical Center Library & Archives'] }
  let(:date) { ['1973-04-09'] }
  let(:holding_entity) { ['Medicl Center Archives'] }
  let(:date_accepted) { ['April 9, 1973'] }
  let(:condition) { ['lid broken'] }
  let(:accrual_method) { ['Donation'] }
  let(:provenance) { ['Found at Yard Sale'] }
  let(:visibility) { Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC }
  let :image do
    Image.new(title: title,
              archival_collection: archival_collection,
              holding_entity: holding_entity,
              date_accepted: date_accepted,
              date: date,
              condition: condition,
              provenance: provenance,
              accrual_method: accrual_method,
              visibility: visibility)
  end

  let(:ability) { Ability.new(user) }

  let(:presenter) do
    described_class.new(SolrDocument.new(image.to_solr), nil)
  end

  it { is_expected.to delegate_method(:title).to(:solr_document) }
  it { is_expected.to delegate_method(:holding_entity).to(:solr_document) }
  it { is_expected.to delegate_method(:date).to(:solr_document) }
  it { is_expected.to delegate_method(:date_accepted).to(:solr_document) }
  it { is_expected.to delegate_method(:condition).to(:solr_document) }
  it { is_expected.to delegate_method(:accrual_method).to(:solr_document) }
  it { is_expected.to delegate_method(:provenance).to(:solr_document) }

end
