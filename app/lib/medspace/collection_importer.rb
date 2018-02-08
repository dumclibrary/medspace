# frozen_string_literal: true
module Medspace
  class CollectionImporter
    attr_reader :doc, :records
    attr_reader :input_file, :formatted_records

    def initialize(input_file)
      Validator.new(input_file).validate_collection
      @input_file = input_file
      @doc = File.open(input_file) { |f| Nokogiri::XML(f) }
      @records = @doc.xpath("//object")
    end

    def process_record(record)
      msci_record = Medspace::Record.new(record)
      collection = CollectionBuilder.new(msci_record.title).find_or_create
      collection.description = msci_record.description
      collection
    end
  end
end
