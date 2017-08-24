# Generated via
#  `rails generate hyrax:work Image`
module Hyrax
  class ImagePresenter < Hyrax::WorkShowPresenter
    delegate :archival_collection, to: :solr_document
    delegate :at_location, to: :solr_document
    delegate :holding_entity, to: :solr_document
    delegate :date, to: :solr_document
    delegate :date_accepted, to: :solr_document
    delegate :accrual_method, to: :solr_document
    delegate :provenance, to: :solr_document
    delegate :condition, to: :solr_document
  end
end
