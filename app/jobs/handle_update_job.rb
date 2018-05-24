##
# A job to update handle metadata with the handle server.
#
# @example
#   object = Pdf.create(title: ['Moomin'])
#   HandleUpdateJob.perform_later(object)
#
# @see ActiveJob::Base, HandleRegistrar#update!
require 'handle'

class HandleUpdateJob < ApplicationJob
  queue_as :handle

  rescue_from(Handle::HandleError) do
    HandleRegistrar::LOGGER
      .log(nil, object.id, "Retrying Handle update for #{object.id}")
    retry_job wait: 30.seconds, queue: :handle
  end

  ##
  # @param object [ActiveFedora::Base]
  def perform(object)
    HandleRegistrar.new.update!(handle: object.handle.first, object: object)
  end
end
