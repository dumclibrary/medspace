# frozen_string_literal: true
# This class represents a record in the Medspace XML
# export:
#
#   <record>
#    <title>Classical macroeconomic model for the United States, a / Thomas J. Sargent.</title>
#    <creator>Sargent, Thomas J.</creator>
# To use the class, pass it an XML document that has been
# opened with Nokogiri:
# msi_record = Medspace::Record.new(record_xml)
#
# then you can access the properties:
# msi_record.title
# > "Classical macroeconomic model for the United States, a"
module Medspace
  class Record
    ##
    # @param record_xml [Nokogiri::XML::Document]
    # Give this class a Nokogiri::XML::Document and it will
    # create a Hash

    def initialize(record_xml)
      @record_xml = record_xml
      @record_hash = Hash.from_xml(record_xml.to_xml)["object"]
    end

    ##
    # @return [Array<String>]
    # returns the creators
    def creator
      get_values(@record_hash["creator"])
    end

    ##
    # @return [Array<String>]
    # returns the descriptions
    def description
      get_values(@record_hash["description"])
    end

    ##
    # @return [Array<String>]
    # the title without the / Author, Name
    # part at the end and without any spaces at the end
    def title
      get_values(@record_hash["title"])
    end

    ##
    # @return [String]
    # returns the type of work that will determine the model
    def work_type
      @record_hash["work_type"]
    end

    ##
    # @return [String] Returns the legacyFileName element
    def file_name
      @record_hash["file"]
    end

    private

      # @param values [String, Array] The value(s) for a single property
      # @return [Array] Returns an array of values with extra whitespace and nil values stripped out.
      def get_values(values)
        values = Array(values)
        values = remove_nils(values)
        strip_whitespace(values)
      end

      ##
      # @param property [Array]
      # @return [Array]
      # this will remove any blanks in the processed XML
      def remove_nils(property)
        property.select { |prop| !prop.nil? }
      end

      ##
      # @param values [Array]
      # @return [Array]
      def strip_whitespace(values)
        values.map(&:strip)
      end
  end
end
