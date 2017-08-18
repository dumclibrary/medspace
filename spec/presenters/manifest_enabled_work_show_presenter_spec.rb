# frozen_string_literal: true
require 'rails_helper'
#require 'hyrax/image_presenter'
#describe Hyrax::ImagePresenter do
describe Hyku::ManifestEnabledWorkShowPresenter do
  subject { presenter }

  let(:title) { ['Apothecary jar. Label: Pom: Pice N:'] }
  let(:holding_entity) { ['Duke Medical Center Library & Archives'] }
  let(:visibility) { Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC }
  let :image do
    Image.new(title: title, holding_entity: holding_entity, visibility: visibility)
  end

  let(:ability) { Ability.new(user) }

  let(:presenter) do
    described_class.new(SolrDocument.new(image.to_solr), nil)
  end

  # If the fields require no addition logic for display, you can simply delegate
  # them to the solr document
  it { is_expected.to delegate_method(:title).to(:solr_document) }
  it { is_expected.to delegate_method(:holding_entity).to(:solr_document) }
end
