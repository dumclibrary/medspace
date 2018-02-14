# Generated via
#  `rails generate hyrax:work ExternalObject`
require 'rails_helper'

RSpec.describe ExternalObject do
  it "requires a title" do
    exo = ExternalObject.new
    exo.date_created = ["1934"]
    exo.description = ["test description"]
    exo.subject = ["Medicine"]
    expect(exo.save).to eq false
    exo.title = ["test"]
    expect(exo.save).to eq true
  end

  it "requires a description" do
    exo = ExternalObject.new
    exo.title = ["test"]
    exo.date_created = ["1934"]
    exo.subject = ["Medicine"]
    expect(exo.save).to eq false
    exo.description = ["test description"]
    expect(exo.save).to eq true
  end

  it "requires a date_created" do
    exo = ExternalObject.new
    exo.title = ["test"]
    exo.description = ["test description"]
    exo.subject = ["Medicine"]
    expect(exo.save).to eq false
    exo.date_created = ["1934"]
    expect(exo.save).to eq true
  end

  it "requires a subject" do
    exo = ExternalObject.new
    exo.title = ["test"]
    exo.description = ["test description"]
    exo.date_created = ["1934"]
    expect(exo.save).to eq false
    exo.subject = ["Medicine"]
    expect(exo.save).to eq true
  end

  it "requires based_near if resource_type is 'Artifact'" do
    exo = ExternalObject.new
    exo.title = ["test"]
    exo.description = ["test description"]
    exo.date_created = ["1934"]
    exo.subject = ["Medicine"]
    exo.resource_type = ["Artifact"]
    expect(exo.save).to eq false
    exo.based_near = ["Room 222"]
    expect(exo.save).to eq true
  end

  it "requires host_organization if resource_type is 'Poster'" do
    exo = ExternalObject.new
    exo.title = ["test"]
    exo.description = ["test description"]
    exo.date_created = ["1934"]
    exo.subject = ["Medicine"]
    exo.resource_type = ["Poster"]
    expect(exo.save).to eq false
    exo.host_organization = ["CDC"]
    expect(exo.save).to eq true
  end

  it "requires host_organization if resource_type is 'Presentation'" do
    exo = ExternalObject.new
    exo.title = ["test"]
    exo.description = ["test description"]
    exo.date_created = ["1934"]
    exo.subject = ["Medicine"]
    exo.resource_type = ["Presentation"]
    expect(exo.save).to eq false
    exo.host_organization = ["Duke University"]
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
