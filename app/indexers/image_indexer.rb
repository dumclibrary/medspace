class ImageIndexer < Medspace::WorkIndexer
  #Inherits common indexing behavior for all Medspace work types
  # Add custom indexing behavior specific to External Objects here
  self.thumbnail_path_service = IIIFThumbnailPathService
end
