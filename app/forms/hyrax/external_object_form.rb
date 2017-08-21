# Generated via
#  `rails generate hyrax:work ExternalObject`
module Hyrax
  class ExternalObjectForm < Hyrax::Forms::WorkForm
    self.model_class = ::ExternalObject
    self.terms += [:resource_type, :holding_entity, :date, :archival_collection]
  end
end
