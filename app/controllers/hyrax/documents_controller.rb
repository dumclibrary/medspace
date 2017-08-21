# Generated via
#  `rails generate hyrax:work Document`

module Hyrax
  class DocumentsController < ApplicationController
    # Adds Hyrax behaviors to the controller.
    include Hyrax::WorksControllerBehavior
    include Hyrax::BreadcrumbsForWorks
    self.curation_concern_type = ::Document

    delegate :archival_collection, to: :solr_document
    delegate :host_organization, to: :solr_document
    delegate :holding_entity, to: :solr_document

    # Use this line if you want to use a custom presenter
    self.show_presenter = Hyrax::DocumentPresenter
  end
end
