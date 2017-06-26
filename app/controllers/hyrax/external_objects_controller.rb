# Generated via
#  `rails generate hyrax:work ExternalObject`

module Hyrax
  class ExternalObjectsController < ApplicationController
    # Adds Hyrax behaviors to the controller.
    include Hyrax::WorksControllerBehavior
    include Hyrax::BreadcrumbsForWorks
    self.curation_concern_type = ::ExternalObject
  end
end
