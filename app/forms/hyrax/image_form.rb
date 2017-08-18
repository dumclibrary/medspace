# Generated via
#  `rails generate hyrax:work Image`
module Hyrax
  class ImageForm < Hyrax::Forms::WorkForm
    self.model_class = ::Image
    self.terms += [:resource_type, :holding_entity, :date]
    self.terms += [:archival_collection, :date_accepted, :condition]
    self.terms += [:accrual_method, :provenance]
  end
end
