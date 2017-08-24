# Generated via
#  `rails generate hyrax:work Image`

module Hyrax
  class ImagesController < ApplicationController
    # Adds Hyrax behaviors to the controller.
    include Hyrax::WorksControllerBehavior
    include Hyrax::BreadcrumbsForWorks
    self.curation_concern_type = ::Image

    self.show_presenter = ImagePresenter

    # Use this line if you want to use a custom presenter
    #self.show_presenter = Hyrax::ImagePresenter
    include Hyku::IIIFManifest

  end
end
