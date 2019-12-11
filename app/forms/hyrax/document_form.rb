# Generated via
#  `rails generate hyrax:work Document`
module Hyrax
  class DocumentForm < Hyrax::Forms::WorkForm
    self.model_class = ::Document
    self.terms += [:resource_type, :holding_entity, :date, :archival_collection, :host_organization, :work_unit, :handle]
    self.required_fields +=[:description, :date_created, :subject]
    self.required_fields -=[:creator, :rights_statement, :keyword]
    self.terms -= [:source, :rights_statement, :license, :based_near, :location, :language, :keyword]
  end
end
