# Generated via
#  `rails generate hyrax:work Document`
require 'rails_helper'

RSpec.describe Document do

  it_behaves_like 'a work with facetable years'

  it "requires a title" do
    doc = Document.new
    doc.date_created = ["1934"]
    doc.subject = ["Medicine"]
    expect(doc.save).to eq false
    doc.description = ["test description"]
    expect(doc.save).to eq false
    doc.title = ["test"]
    #expect(doc.save).to eq true
  end

  it "requires a description" do
    doc = Document.new
    doc.title = ["test"]
    doc.date_created = ["1934"]
    doc.subject = ["Medicine"]
    expect(doc.save).to eq false
    doc.description = ["test description"]
    expect(doc.save).to eq true
  end

  it "requires a date_created" do
    doc = Document.new
    doc.title = ["test"]
    doc.description = ["test description"]
    doc.subject = ["Medicine"]
    expect(doc.save).to eq false
    doc.date_created = ["1934"]
    expect(doc.save).to eq true
  end

  it "requires a subject" do
    doc = Document.new
    doc.title = ["test"]
    doc.description = ["test description"]
    doc.date_created = ["1934"]
    expect(doc.save).to eq false
    doc.subject = ["Medicine"]
    expect(doc.save).to eq true
  end

  it "requires based_near if resource_type is 'Artifact'" do
    doc = Document.new
    doc.title = ["test"]
    doc.description = ["test description"]
    doc.date_created = ["1934"]
    doc.subject = ["Medicine"]
    doc.resource_type = ["Artifact"]
    expect(doc.save).to eq false
    doc.based_near = ["Room 222"]
    expect(doc.save).to eq true
  end

  it "requires host_organization if resource_type is 'Poster'" do
    doc = Document.new
    doc.title = ["test"]
    doc.description = ["test description"]
    doc.date_created = ["1934"]
    doc.subject = ["Medicine"]
    doc.resource_type = ["Poster"]
    expect(doc.save).to eq false
    doc.host_organization = ["CDC"]
    #expect(doc.save).to eq true
  end

  it "requires host_organization if resource_type is 'Presentation'" do
    doc = Document.new
    doc.title = ["test"]
    doc.description = ["test description"]
    doc.date_created = ["1934"]
    doc.subject = ["Medicine"]
    doc.resource_type = ["Presentation"]
    expect(doc.save).to eq false
    doc.host_organization = ["Duke University"]
    expect(doc.save).to eq true
  end

  it "can add a holding entity" do
    doc = Document.new
    expect(doc.holding_entity).to be_empty
    doc.holding_entity = ["my location"]
    expect(doc.holding_entity.first).to eq "my location"
#    expect(doc.resource.dump(:ttl)).to match(/www.loc.gov\/mods\/rdf\/v1#locationPhysical/)
  end

  it "can add a sorting date" do
    doc = Document.new
    expect(doc.date).to be_empty
    doc.date = ["1973-04-09"]
    expect(doc.date.first).to eq "1973-04-09"
    #expect(doc.resource.dump(:ttl)).to match(/www.loc.gov\/mods\/rdf\/v1#locationPhysical/)
  end

  it "can add an archival collection" do
    doc = Document.new
    expect(doc.archival_collection).to be_empty
    doc.archival_collection = ["DUMC Archives"]
    expect(doc.archival_collection.first).to eq "DUMC Archives"
    #expect(doc.resource.dump(:ttl)).to match(/www.loc.gov\/mods\/rdf\/v1#locationPhysical/)
  end

  it "can add a host organization" do
    doc = Document.new
    expect(doc.host_organization).to be_empty
    doc.host_organization = ["Medical Library Association"]
    expect(doc.host_organization.first).to eq "Medical Library Association"
    #expect(doc.resource.dump(:ttl)).to match(/www.loc.gov\/mods\/rdf\/v1#locationPhysical/)
  end

end
