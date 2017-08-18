module Dumcla
  module Metadata
    module Descriptive
      extend ActiveSupport::Concern
      included do
        property :holding_entity, predicate: ::RDF::Vocab::MODS.locationPhysical do |index|
          index.as :stored_searchable, :facetable
        end
      end
    end
  end
end
