# Generated via
#  `rails generate hyrax:work ExternalObject`
require 'rails_helper'

RSpec.describe Hyrax::ExternalObjectPresenter do
    subject { presenter }

    let(:title) { ['Apothecary jar. Label: Pom: Pice N:'] }
    let(:archival_collection) { ['Duke Medical Center Library & Archives'] }
    let(:date) { ['1973-04-09'] }
    let(:holding_entity) { ['Medicl Center Archives'] }
    let(:visibility) { Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC }
    let :exo do
      ExternalObject.new(title: title,
                archival_collection: archival_collection,
                holding_entity: holding_entity,
                date: date,
                visibility: visibility)
    end

    let(:ability) { Ability.new(user) }

    let(:presenter) do
      described_class.new(SolrDocument.new(exo.to_solr), nil)
    end

    it { is_expected.to delegate_method(:title).to(:solr_document) }
    it { is_expected.to delegate_method(:holding_entity).to(:solr_document) }
    it { is_expected.to delegate_method(:date).to(:solr_document) }
    it { is_expected.to delegate_method(:archival_collection).to(:solr_document) }

  end
