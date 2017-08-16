# Generated via
#  `rails generate hyrax:work Image`
module Hyrax
  class ImageForm < Hyrax::Forms::WorkForm
    self.model_class = ::Image
    self.terms += [:resource_type, :holding_entity]
    self.required_fields -=[:creator, :keyword, :rights]
    self.required_fields +=[:description, :subject]
  end
end
