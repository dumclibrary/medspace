# Generated via
#  `rails generate hyrax:work Document`
require 'rails_helper'

RSpec.describe Document do

  it "requires a title" do
    doc = Document.new
    expect(doc.save).to eq false
    doc.title = ["test"]
    expect(doc.save).to eq true
  end

  it "can add a holding entity" do
    doc = Document.new
    expect(doc.holding_entity).to be_empty
    doc.holding_entity = ["my location"]
    expect(doc.holding_entity.first).to eq "my location"
#    expect(image.resource.dump(:ttl)).to match(/www.loc.gov\/mods\/rdf\/v1#locationPhysical/)
  end

  it "can add a sorting date" do
    doc = Document.new
    expect(doc.date).to be_empty
    doc.date = ["1973-04-09"]
    expect(doc.date.first).to eq "1973-04-09"
    #expect(image.resource.dump(:ttl)).to match(/www.loc.gov\/mods\/rdf\/v1#locationPhysical/)
  end


  it "can add an archival collection" do
    doc = Document.new
    expect(doc.archival_collection).to be_empty
    doc.archival_collection = ["DUMC Archives"]
    expect(doc.archival_collection.first).to eq "DUMC Archives"
    #expect(image.resource.dump(:ttl)).to match(/www.loc.gov\/mods\/rdf\/v1#locationPhysical/)
  end

  it "can add a host organization" do
    doc = Document.new
    expect(doc.host_organization).to be_empty
    doc.host_organization = ["Medical Library Association"]
    expect(doc.host_organization.first).to eq "Medical Library Association"
    #expect(image.resource.dump(:ttl)).to match(/www.loc.gov\/mods\/rdf\/v1#locationPhysical/)
  end

end
