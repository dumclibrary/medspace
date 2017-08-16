# Generated via
#  `rails generate hyrax:work Image`
class Image < ActiveFedora::Base
  include ::Hyrax::WorkBehavior
  include ::Hyrax::BasicMetadata
  # Change this to restrict which works can be added as a child.
  # self.valid_child_concerns = []
  validates :title, presence: { message: 'Your work must have a title.' }


    self.indexer = ImageIndexer

  self.human_readable_type = 'Image'

  property :holding_entity, predicate: ::RDF::Vocab::MODS.locationPhysical do |index|
    index.as :stored_searchable, :facetable
  end

end
