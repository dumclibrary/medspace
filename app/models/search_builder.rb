# frozen_string_literal: true
class SearchBuilder < Hyrax::CatalogSearchBuilder
  include Blacklight::Solr::SearchBuilderBehavior
  include BlacklightRangeLimit::RangeLimitBuilder

  # Add a filter query to restrict the search to documents the current user has access to
  # NOTE: these are already included in Hyrax::CatalogSearchBuilder
  # include Hydra::AccessControlsEnforcement
  # include Hyrax::SearchFilters


  ##
  # @example Adding a new step to the processor chain
  #   self.default_processor_chain += [:add_custom_data_to_query]
  #
  #   def add_custom_data_to_query(solr_parameters)
  #     solr_parameters[:custom] = blacklight_params[:user_value]
  #   end
end
