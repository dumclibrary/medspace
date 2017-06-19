# Generated via
#  `rails generate hyrax:work Image`
class ImageIndexer < Hyrax::WorkIndexer

  # Use thumbnails served by RIIIF
  self.thumbnail_path_service = IIIFThumbnailPathService

  # Uncomment this block if you want to add custom indexing behavior:
  # def generate_solr_document
  #  super.tap do |solr_doc|
  #    solr_doc['my_custom_field_ssim'] = object.my_custom_property
  #  end
  # end
end
