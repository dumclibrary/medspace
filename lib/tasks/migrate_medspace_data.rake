# frozen_string_literal: true
namespace :import do
  desc "Import data from Medspace export"
  task medspace: :environment do
    import_data
    exit 0 # Make sure extra args aren't misinterpreted as rake task args
  end

  # helpers
  def import_data
    options = options(ARGV)
    puts "Importing records using options: #{options}"

    directory = options[:directory]
    xml_files = File.join(directory, "*.xml")
    works = 0
    works = Image.all.size + Document.all.size + ExternalObject.all.size
    Dir.glob(xml_files).each do |file|
      Medspace::Importer.import(file, directory)
      new_works = Image.all.size + Document.all.size + ExternalObject.all.size
      puts "Import complete: #{new_works - works} created."
    end
  end

  # Read the options that the user supplied on the command line.

  def options(args)
    require 'optparse'
    user_inputs = {}
    opts = OptionParser.new

    opts.on('-i DIRECTORY', '--directory', '(required) The directory of xml files you want to import') do |directory|
      user_inputs[:directory] = directory
    end

    opts.on('-h', '--help', 'Print this help message') do
      puts opts
      exit 0
    end

    args = opts.order!(ARGV) {}
    opts.parse!(args)

    required_options = [:directory]
    missing_options = required_options - user_inputs.keys
    missing_options.each { |o| puts "Error: Missing required option: --#{o}" }

    # If any required options are missing, print the usage message and abort.
    if !missing_options.blank?
      puts ""
      puts opts
      exit 1
    end

    user_inputs
  end
end
