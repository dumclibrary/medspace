# frozen_string_literal: true
module Dumcla
  module Validation
    extend ActiveSupport::Concern
    included do
      validates :title, presence: { message: 'Your work must have a title.' }

      validates :description, presence: { message: 'Your work must have a description.' }

      validates :date_created, presence: { message: 'Your work must have a create date.' }

      validates :subject, presence: { message: 'Your work must have a subject.' }

      validates :based_near, presence: { message: 'Your work must have a based_near property.' }, if: :based_near?

      validates :host_organization, presence: { message: 'Your work must have a host_organization property.' }, if: :host_organization?

      def based_near?
        resource_type == ['Artifact']
      end

      def host_organization?
        resource_type == ['Poster'] || resource_type == ['Presentation']
      end
    end
  end
end
