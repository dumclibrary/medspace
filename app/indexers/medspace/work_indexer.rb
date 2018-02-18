module Medspace
  class WorkIndexer < Hyrax::WorkIndexer

    # This indexes the default metadata. You can remove it if you want to
    # provide your own metadata and indexing.
    include Hyrax::IndexesBasicMetadata

    # Fetch remote labels for based_near. You can remove this if you don't want
    # this behavior
    include Hyrax::IndexesLinkedMetadata

    self.thumbnail_path_service = Hyrax::WorkThumbnailPathService

    # Custom indexing behavior:
    def generate_solr_document
      super.tap do |solr_doc|
        titles = solr_doc[Solrizer.solr_name('title', :stored_searchable)] || []
        solr_doc['title_ssort'] = titles.to_sentence
        solr_doc['year_iim'] = extract_years(object.date)
      end
    end

    # Converts an array of strings into an array of corresponding years as integers
    # @param dates [Array<String>] a list of dates in some textual format
    # @return [Array<Integer>] a list of integers representing the years referenced in the dates
    def extract_years(dates)
      dates.flat_map{ |date| extract_year(date) }.uniq
    end

    # Return an integer corresponding to the year in a string representing a date
    # Accepts years in form YYYY, iso8601, and ranges YYYY-YYYY
    # @param date [String]
    # @return [Array<Integer>] the four digit integer(s) corresponding to year(s) in the date or date range
    def extract_year(date)
      if date.blank?
        [nil]
      elsif /^\d{4}$/ =~ date
        # Date.iso8601 doesn't support YYYY dates
        [date.to_i]
      elsif /^\d{4}-\d{4}$/ =~ date
        # date range in YYYY-YYYY format
        earliest, latest = date.split('-').flat_map{ |y| y.to_i }
        (earliest..latest).to_a
      else
        [Date.iso8601(date).year]
      end
    rescue ArgumentError
      raise "Invalid date: #{date.inspect}"
    end

  end

end