# Generated via
#  `rails generate hyrax:work ExternalObject`
module Hyrax
  class ExternalObjectForm < Hyrax::Forms::WorkForm
    self.model_class = ::ExternalObject
    self.terms += [:resource_type]
    self.required_fields -=[:creator, :keyword, :rights]
    self.required_fields +=[:description, :subject]
  end
end
