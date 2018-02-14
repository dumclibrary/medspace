# frozen_string_literal: true

# This class looks for the file that will be imported
# in the data_path directory. It then creates a
# Hyrax::UploadedFile object by reading the file.
# This will be used in the importer to actually import
# the file with its metadata into Hyrax.
#
# The files that are in that data_path folder should
# have a filename that is the same as the
# `<legacyFileName>` element in the MSI XML.
module Medspace
  class ImportFile
    ##
    # @param record data_path user [Medspace::Record, String, User]
    def initialize(record, data_path, user)
      @record = record
      @data_path = data_path
      @user = user
    end

    # this returns a Hyrax::Uploaded file object, that will be used when importing
    # @return [Hyrax::UploadedFile, nil]
    def uploaded_file
      return nil if @record.file_name.blank?
      if @record.file_name.is_a? Array
        @record.file_name.each do |file_name|
          _uploaded_file(file_name)
        end
      else
        _uploaded_file(@record.file_name)
      end
    end

    ##
    # @return [String]
    # this returns the full path to the file
    def file_path(file_name)
      "#{@data_path}/#{file_name}"
    end

    def check_for_file(full_path)
      File.file?(full_path)
    end

    private

      def _uploaded_file(file_name)
        if check_for_file(file_path(file_name))
          Medspace::Log.new("Loading file: #{File.basename(file_path(file_name))}", 'info')
          Hyrax::UploadedFile.create(user: @user, file: File.open(file_path(file_name), 'r'))
        else
          Medspace::Log.new("This file does not exist: #{file_path(file_name)}", 'error')
        end
      end
  end
end
