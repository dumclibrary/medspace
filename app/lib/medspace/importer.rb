# frozen_string_literal: true
require 'nokogiri'

# An importer for Medspace exported Metadata
module Medspace
  class Importer
    attr_reader :doc, :records
    attr_reader :input_file, :data_path

    # @param input_file [String] the path to the XML file that contains the exported records from ContentDM.
    # @param data_path [String] the path to directory where the content files are located.
    # @param default_model [String] the type of work we want to create if the <work_type> isn't specified in the XML file.
    def initialize(input_file, data_path)
      # Validator.new(input_file).validate
      @input_file = input_file
      @data_path = data_path
      @doc = File.open(input_file) { |f| Nokogiri::XML(f) }
      @records = @doc.xpath("//object")
      @collection = collection
    end

    # Class level method, to be called, e.g., from a rake task
    # @example
    # Medspace::Importer.import('my_file.xml', 'path/to/data_dir')
    def self.import(input_file, data_path)
      Importer.new(input_file, data_path).import
    end

    def import
      @records.each do |record|
        work = process_record(record)
        Medspace::Log.new("Adding #{work.id} to collection: #{collection_name}", 'info')
      end
      @collection.save
    end

    def document_count
      @records.count
    end

    def process_record(record)
      msi_record = Medspace::Record.new(record)
      work_type = work_model(msi_record.work_type)
      # Medspace::Log.new("Creating new #{work_type} for #{msi_record.legacy_file_name}", 'info')
      work = work_type.new
      work.title = msi_record.title
      work.creator = msi_record.creator
      # work.contributor = msi_record.contributor
      # work.subject = msi_record.subject
      work.description = msi_record.description
      # work.requires = msi_record.requires
      # work.replaces = msi_record.replaces
      # work.abstract = msi_record.abstract
      work.visibility = Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC
      save_work(msi_record, work)
      @collection.add_members(work.id)
      work
    end

    ##
    # @return [Array<String>] this returns the name of the collection based on the XML

    def collection_name
      [@doc.xpath("//collection").text]
    end

    ##
    # @return [ActiveFedora::Base] return the collection object
    def collection
      CollectionBuilder.new(collection_name).find_or_create
    end

    # Converts a class name into a class.
    # @param class_name [String] the type of work we want to create, 'Image'.
    # @return [Class] return the work's class
    # @example If you pass in a string 'Image', it returns the class ::Image
    def work_model(class_name = nil)
      class_name.constantize
    rescue NameError
      raise "Invalid work type: #{class_name}"
    end

    private

      def save_work(msi_record, work)
        importer_user = ::User.batch_user
        current_ability = ::Ability.new(importer_user)

        uploaded_file = Medspace::ImportFile.new(msi_record, data_path, importer_user).uploaded_file
        uploaded_file_id = uploaded_file.try(:id)
        attributes = { uploaded_files: [uploaded_file_id] }

        env = Hyrax::Actors::Environment.new(work, current_ability, attributes)
        if Hyrax::CurationConcern.actor.create(env) != false
          Medspace::Log.new("Saved work with title: #{msi_record.title[0]}", 'info')
        else
          Medspace::Log.new("Problem saving #{msi_record.legacy_file_name}", 'error')
        end
      end
  end
end
