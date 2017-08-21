# Generated via
#  `rails generate hyrax:work Document`
require 'rails_helper'

RSpec.describe Hyrax::DocumentPresenter do
  subject { presenter }

  let(:title) { ['Apothecary jar. Label: Pom: Pice N:'] }
  let(:archival_collection) { ['Duke Medical Center Library & Archives'] }
  let(:date) { ['1973-04-09'] }
  let(:holding_entity) { ['Medicl Center Archives'] }
  let(:host_organization) { ['Medical Library Association']}
  let(:visibility) { Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC }
  let :doc do
    Document.new(title: title,
              archival_collection: archival_collection,
              holding_entity: holding_entity,
              date: date,
              host_organization: host_organization,
              visibility: visibility)
  end

  let(:ability) { Ability.new(user) }

  let(:presenter) do
    described_class.new(SolrDocument.new(doc.to_solr), nil)
  end

  it { is_expected.to delegate_method(:title).to(:solr_document) }
  it { is_expected.to delegate_method(:holding_entity).to(:solr_document) }
  it { is_expected.to delegate_method(:date).to(:solr_document) }
  it { is_expected.to delegate_method(:archival_collection).to(:solr_document) }
  it { is_expected.to delegate_method(:host_organization).to(:solr_document) }

end
