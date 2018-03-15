# Generated via
#  `rails generate hyrax:work Document`
module Hyrax
  class DocumentPresenter < Hyrax::WorkShowPresenter
    delegate :archival_collection, to: :solr_document
    delegate :holding_entity, to: :solr_document
    delegate :host_organization, to: :solr_document
    delegate :date, to: :solr_document
    delegate :handle, to: :solr_document
  end
end
