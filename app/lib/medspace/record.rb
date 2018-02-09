# frozen_string_literal: true
# This class represents a record in the Medspace XML
# export:
#
#   <record>
#    <title>Exhibit Room B, postgraduate course on fractures</title>
#    <subject>Education, Medical</subject>
# To use the class, pass it an XML document that has been
# opened with Nokogiri:
# msi_record = Medspace::Record.new(record_xml)
#
# then you can access the properties:
# msi_record.title
# > "Exhibit Room B, postgraduate course on fractures"
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
    # returns the date_created
    def date_created
      get_values(@record_hash["date_created"])
    end

    ##
    # @return [Array<String>]
    # returns the descriptions
    def description
      description = @record_xml.xpath('//description')
      get_values(description.collect(&:content))
    end

    ##
    # @return [Array<String>]
    # returns the title
    def title
      get_values(@record_hash["title"])
    end

    ##
    # @return [Array<String>]
    # returns the contributor
    def contributor
      get_values(@record_hash["contributor"])
    end

    ##
    # @return [Array<String>]
    # returns the identifier
    def identifier
      get_values(@record_hash["identifier"])
    end

    ##
    # @return [Array<String>]
    # returns the archival_collection
    def archival_collection
      get_values(@record_hash["archival_collection"])
    end

    ##
    # @return [Array<String>]
    # returns the date
    def date
      get_values(@record_hash["date"])
    end

    ##
    # @return [Array<String>]
    # returns the date accepted
    def date_accepted
      get_values(@record_hash["date_accepted"])
    end

    ##
    # @return [Array<String>]
    # returns the condition
    def condition
      get_values(@record_hash["condition"])
    end

    ##
    # @return [Array<String>]
    # returns the accrual_method
    def accrual_method
      get_values(@record_hash["accrual_method"])
    end

    ##
    # @return [Array<String>]
    # returns the provenance
    def provenance
      get_values(@record_hash["provenance"])
    end

    ##
    # @return [Array<String>]
    # returns the publishers
    def publisher
      get_values(@record_hash["publisher"])
    end

    ##
    # @return [Array<String>]
    # returns based_near
    def based_near
      get_values(@record_hash["based_near"])
    end

    ##
    # @return [Array<String>]
    # returns the related_url
    def related_url
      get_values(@record_hash["related_url"])
    end

    ##
    # @return [Array<String>]
    # returns the resource type
    def resource_type
      get_values(@record_hash["resource_type"])
    end

    ##
    # @return [Array<String>]
    # returns the holding entity
    def holding_entity
      get_values(@record_hash["holding_entity"])
    end

    ##
    # @return [Array<String>]
    # returns the host organization
    def host_organization
      get_values(@record_hash["host_organization"])
    end

    ##
    # @return [String]
    # returns the type of work that will determine the model
    def work_type
      @record_hash["work_type"]
    end

    ##
    # @return [String] Returns the File element
    def file_name
      @record_hash["file"]
    end

    ##
    # @return [Array<String>]
    # returns the subjects
    def subject
      get_values(@record_hash["subject"])
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
