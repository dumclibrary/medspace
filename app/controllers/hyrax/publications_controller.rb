# Generated via
#  `rails generate hyrax:work Publication`

module Hyrax
  class PublicationsController < ApplicationController
    # Adds Hyrax behaviors to the controller.
    include Hyrax::WorksControllerBehavior
    include Hyrax::BreadcrumbsForWorks
    self.curation_concern_type = ::Publication
  end
end
