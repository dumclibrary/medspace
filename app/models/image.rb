# frozen_string_literal: true
# Generated via `rails generate hyrax:work Image`
class Image < ActiveFedora::Base
  include ::Hyrax::WorkBehavior
  include ::Dumcla::Metadata::Descriptive

  self.indexer = ImageIndexer
  # Change this to restrict which works can be added as a child.
  # self.valid_child_concerns = []
  validates :title, presence: { message: 'Your work must have a title.' }

  validates :description, presence: { message: 'Your work must have a description.' }

  validates :date_created, presence: { message: 'Your work must have a create date.' }

  validates :subject, presence: { message: 'Your work must have a subject.' }

  validates :based_near, presence: { message: 'Your work must have a based_near property.' }, if: :based_near?

  validates :host_organization, presence: { message: 'Your work must have a host_organization property.' }, if: :host_organization?

  self.human_readable_type = 'Image'

  # This must be included at the end, because it finalizes the metadata
  # schema (by adding accepts_nested_attributes)
  include ::Hyrax::BasicMetadata

  def based_near?
    resource_type == ['Artifact']
  end

  def host_organization?
    resource_type == ['Poster'] || resource_type == ['Presentation']
  end
end
