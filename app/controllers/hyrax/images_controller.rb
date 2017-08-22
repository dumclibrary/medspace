# Generated via
#  `rails generate hyrax:work Image`

module Hyrax
  class ImagesController < ApplicationController
    # Adds Hyrax behaviors to the controller.
    include Hyrax::WorksControllerBehavior
    include Hyrax::BreadcrumbsForWorks
    self.curation_concern_type = ::Image

    delegate :archival_collection, to: :solr_document
    delegate :condition, to: :solr_document
    delegate :accrual_method, to: :solr_document
    delegate :holding_entity, to: :solr_document
    delegate :date, to: :solr_document
    delegate :date_accepted, to: :solr_document
    delegate :provenance, to: :solr_document

    # Use this line if you want to use a custom presenter
    #self.show_presenter = Hyrax::ImagePresenter
    include Hyku::IIIFManifest

  end
end
