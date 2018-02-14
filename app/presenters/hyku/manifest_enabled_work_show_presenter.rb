module Hyku
  class ManifestEnabledWorkShowPresenter < Hyrax::WorkShowPresenter
    Hyrax::MemberPresenterFactory.file_presenter_class = Hyku::FileSetPresenter

    delegate :extent, to: :solr_document
      delegate :archival_collection, to: :solr_document
      delegate :at_location, to: :solr_document
      delegate :holding_entity, to: :solr_document
      delegate :date, to: :solr_document
      delegate :date_accepted, to: :solr_document
      delegate :accrual_method, to: :solr_document
      delegate :based_near, to: :solr_document
      delegate :provenance, to: :solr_document
      delegate :condition, to: :solr_document
    def manifest_url
      manifest_helper.polymorphic_url([:manifest, self])
    end

    private

      def manifest_helper
        @manifest_helper ||= ManifestHelper.new(request.base_url)
      end
  end
end
