# frozen_string_literal: true
# Generated via `rails generate hyrax:work ExternalObject`
class ExternalObject < ActiveFedora::Base
  include ::Hyrax::WorkBehavior
  include ::Dumcla::Metadata::Descriptive

  self.indexer = ExternalObjectIndexer
  include ::Dumcla::Validation
  # Change this to restrict which works can be added as a child.
  # self.valid_child_concerns = []

  #self.human_readable_type = 'External Object'

  # This must be included at the end, because it finalizes the metadata
  # schema (by adding accepts_nested_attributes)
  include ::Hyrax::BasicMetadata
end
