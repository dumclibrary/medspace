class Hyrax::HomepageController < ApplicationController
  include Hyrax::HomepageControllerBehavior

  def index
    @collection = Collection.all
    super
  end
  
end
