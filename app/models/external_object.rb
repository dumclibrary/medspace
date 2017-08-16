# Generated via
#  `rails generate hyrax:work ExternalObject`
class ExternalObject < ActiveFedora::Base
  include ::Hyrax::WorkBehavior
  include ::Dumcla::Metadata::Descriptive
  include ::Hyrax::BasicMetadata
  # Change this to restrict which works can be added as a child.
  # self.valid_child_concerns = []
  validates :title, presence: { message: 'Your work must have a title.' }

  self.human_readable_type = 'External Object'
end
