# Generated via
#  `rails generate hyrax:work ExternalObject`

module Hyrax
  class ExternalObjectsController < ApplicationController
    # Adds Hyrax behaviors to the controller.
    include Hyrax::WorksControllerBehavior
    include Hyrax::BreadcrumbsForWorks
    self.curation_concern_type = ::ExternalObject

    delegate :archival_collection, to: :solr_document
    delegate :holding_entity, to: :solr_document
    delegate :date, to: :solr_document

    # Use this line if you want to use a custom presenter
    self.show_presenter = Hyrax::ExternalObjectPresenter
  end
end
