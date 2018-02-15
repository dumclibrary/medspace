# frozen_string_literal: true
# Generated via `rails generate hyrax:work Document`
class Document < ActiveFedora::Base
  include ::Hyrax::WorkBehavior
  include ::Dumcla::Metadata::Descriptive

  self.indexer = DocumentIndexer
  # Change this to restrict which works can be added as a child.
  # self.valid_child_concerns = []
  include ::Dumcla::Validation

  #self.human_readable_type = 'Document'

  # This must be included at the end, because it finalizes the metadata
  # schema (by adding accepts_nested_attributes)
  include ::Hyrax::BasicMetadata
end
