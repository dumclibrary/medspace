# Generated via
#  `rails generate hyrax:work ExternalObject`
require 'rails_helper'

RSpec.describe ExternalObject do
  it "requires a title" do
    exo = ExternalObject.new
    expect(exo.save).to eq false
    exo.title = ["test"]
    expect(exo.save).to eq true
  end

  it "can add a holding entity" do
    exo = ExternalObject.new
    expect(exo.holding_entity).to be_empty
    exo.holding_entity = ["my location"]
    expect(exo.holding_entity.first).to eq "my location"
#    expect(image.resource.dump(:ttl)).to match(/www.loc.gov\/mods\/rdf\/v1#locationPhysical/)
  end

  it "can add a sorting date" do
    exo = ExternalObject.new
    expect(exo.date).to be_empty
    exo.date = ["1973-04-09"]
    expect(exo.date.first).to eq "1973-04-09"
    #expect(image.resource.dump(:ttl)).to match(/www.loc.gov\/mods\/rdf\/v1#locationPhysical/)
  end


  it "can add an archival collection" do
    exo = ExternalObject.new
    expect(exo.archival_collection).to be_empty
    exo.archival_collection = ["DUMC Archives"]
    expect(exo.archival_collection.first).to eq "DUMC Archives"
    #expect(image.resource.dump(:ttl)).to match(/www.loc.gov\/mods\/rdf\/v1#locationPhysical/)
  end

end
