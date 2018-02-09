# frozen_string_literal: true
module Medspace
  class CollectionImporter
    attr_reader :doc, :records
    attr_reader :input_file, :formatted_records

    def initialize(input_file)
      @valid = Validator.new(input_file).validate_collection
      @input_file = input_file
      @doc = File.open(input_file) { |f| Nokogiri::XML(f) }
      @records = @doc.xpath("//object")
    end

    # Class level method, to be called from a rake task
    # @example
    # Medspace::CollectionImporter.import('my_file.xml')
    def self.import(input_file)
      CollectionImporter.new(input_file).import
    end

    def import
      @records.each do |record|
        process_record(record)
      end
    end

    def collection_name
      [@doc.xpath("//title").text]
    end

    def process_record(record)
      return unless @valid
      msci_record = Medspace::Record.new(record)
      collection = CollectionBuilder.new(msci_record.title).find_or_create
      collection.description = msci_record.description
      collection.resource_type = msci_record.resource_type
      collection.save!
      collection
    end
  end
end
