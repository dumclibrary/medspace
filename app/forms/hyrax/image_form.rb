# Generated via
#  `rails generate hyrax:work Image`
module Hyrax
  class ImageForm < Hyrax::Forms::WorkForm
    self.model_class = ::Image
    self.terms += [:resource_type, :holding_entity, :date]
    self.terms += [:archival_collection, :date_accepted, :condition]
    self.terms += [:accrual_method, :provenance, :at_location]
    self.terms -= [:source, :based_near, :language, :keyword]
    self.required_fields +=[:description, :date_created, :subject]
    self.required_fields -=[:creator, :rights_statement, :keyword]
  end
end
