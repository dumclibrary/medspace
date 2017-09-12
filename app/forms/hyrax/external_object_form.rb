# Generated via
#  `rails generate hyrax:work ExternalObject`
module Hyrax
  class ExternalObjectForm < Hyrax::Forms::WorkForm
    self.model_class = ::ExternalObject
    self.terms += [:resource_type, :holding_entity, :date, :archival_collection]
    self.required_fields +=[:description, :date_created, :subject]
    self.required_fields -=[:creator, :rights_statement, :keyword]
    self.terms -= [:source, :rights_statement, :license, :based_near, :location, :language, :keyword]
  end
end
