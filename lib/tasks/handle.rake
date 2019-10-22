require 'rake'

namespace :handle do
    ##
    # @example using control-flow-or to exit a rake task when no object is found
    #   object = find_or_warn('not_an_id') || next
    #
    # @param id [String]
    # @return [ActiveFedora::Base, false]
    def find_or_warn(id)
      ActiveFedora::Base.find(id)
    rescue ActiveFedora::ObjectNotFoundError
      $stderr.puts "Unable to find an ActiveFedora::Base object for id: #{id}"
      false
    end

    desc 'Registers handles for all objects that do not already have one'
    task :register_all => :environment do
      [Image, Document, ExternalObject].each do |model_class|
        model_class.all.each do |work|
          if work.handle.nil? || work.handle.empty?
            handle = HandleDispatcher.assign_for!(object: work, attribute: :handle)
            puts "Registered a handle #{handle} for #{work}"
          end
        end
      end
    end

    desc 'Registers a handle for the object. Supply an id.'
    task :register, [:id] => :environment do |_, args|
      object = find_or_warn(args[:id]) || next

      if object.handle.nil?
      #if object.handle.empty?
        handle = HandleDispatcher.assign_for!(object: object)
        puts "Registered a handle #{handle} for #{args[:id]}"
      else
        puts "Identifier(s) exist for #{args[:id]}: #{object.handle}"
      end
    end

    desc 'Ensures that the handle for the object is up to date. Supply an id.'
    task :update, [:id] => :environment do |_, args|
      object = find_or_warn(args[:id]) || next

      if object.handle.nil?
      #if object.handle.empty?
        $stderr.puts "No handle is registered for the object: #{object.uri}"
        next
      else
        HandleRegistrar.new.update!(handle: object.handle.first,
                                    object: object)
      end
    end
  end
