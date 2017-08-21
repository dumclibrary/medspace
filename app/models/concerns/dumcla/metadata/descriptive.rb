module Dumcla
  module Metadata
    module Descriptive
      extend ActiveSupport::Concern
      included do
        property :holding_entity, predicate: ::RDF::Vocab::MODS.locationPhysical do |index|
          index.as :stored_searchable, :facetable
        end
        property :date, predicate: ::RDF::Vocab::DC11.date do |index|
          index.as :stored_searchable, :facetable
        end
        property :archival_collection, predicate: ::RDF::Vocab::BIBO.Collection do |index|
          index.as :stored_searchable, :facetable
        end

        # Image only metadata
        property :date_accepted, predicate: ::RDF::Vocab::DC.dateAccepted do |index|
          index.as :stored_searchable
        end
        property :condition, predicate: ::RDF::Vocab::GR.condition do |index|
          index.as :stored_searchable
        end
        property :accrual_method, predicate: ::RDF::Vocab::DC.accrualMethod do |index|
          index.as :stored_searchable
        end
        property :provenance, predicate: ::RDF::Vocab::DC.provenance do |index|
          index.as :stored_searchable
        end

        # document specific metadata
        property :host_organization, predicate: ::RDF::Vocab::MARCRelators.his do |index|
          index.as :stored_searchable, :facetable
        end
      end
    end
  end
end
