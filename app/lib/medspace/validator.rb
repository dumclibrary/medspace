# frozen_string_literal: true
module Medspace
  # This class loads a RelaxNG schema that is used to validate
  # the Medspace export xml.
  class Validator
    attr_reader :result

    ##
    # @param [File] xml_file
    # @return [Array]
    # Sets the result of validation during the init
    def initialize(xml_file)
      schema_file = Rails.root.join('app', 'lib', 'medspace', 'schema', 'medspace_export.rng')
      schema = Nokogiri::XML::RelaxNG(File.open(schema_file))
      @xml = File.basename(xml_file)
      @doc = Nokogiri::XML(File.open(xml_file))
      @result = schema.validate(@doc)
      @errors = []
    end

    ##
    # @return [Boolean]
    # Returns a boolean for the validation result
    def valid?
      @result.empty? && required_nodes?
    end

    ##
    # @return [Boolean]
    # Returns a boolean for the validation result
    def valid_collection?
      required_collection_nodes?
    end

    ##
    # Returns a boolean for validation result
    def required_collection_nodes?
      title? && description?
      @errors.empty?
    end
    ##

    # Returns a boolean for validation result
    def required_nodes?
      subject? && description? && date_created? && at_location? && host_organization?
      @errors.empty?
    end

    ##
    # This method will log the result of validation
    def validate
      if valid?
        Medspace::Log.new("XML: #{@xml} is valid", 'info')
      else
        Medspace::Log.new("XML: #{@xml} is invalid. The errors are: #{@errors}", 'error')
      end
    end

    def validate_collection
      if valid_collection?
        Medspace::Log.new("XML: #{@xml} is valid", 'info')
        true
      else
        Medspace::Log.new("XML: #{@xml} is invalid. The errors are: #{@errors}", 'error')
        false
      end
    end

    private

      # title is validated by the schema for objects, here for collections
      def title?
        if @doc.xpath('object//title').empty?
          @errors << "Missing title"
          return false
        end
        true
      end

      def subject?
        if @doc.xpath('object//subject').empty?
          @errors << "Missing subject"
          return false
        end
        true
      end

      def description?
        if @doc.xpath('object//description').empty?
          @errors << "Missing description"
          return false
        end
        true
      end

      def date_created?
        if @doc.xpath('object//date_created').empty?
          @errors << "Missing date_created"
          return false
        end
        true
      end

      def at_location?
        if @doc.xpath('object//resource_type').text == 'Artifact' && @doc.xpath('object//at_location').empty?
          @errors << "Missing at_location"
          return false
        end
        true
      end

      def host_organization?
        if (@doc.xpath('object//resource_type').text == 'Poster' || @doc.xpath('object//resource_type').text == 'Presentation') && @doc.xpath('object//host_organization').empty?
          @errors << "Missing host_organization"
          return false
        end
        true
      end
  end
end
