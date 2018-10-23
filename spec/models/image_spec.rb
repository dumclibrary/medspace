# frozen_string_literal: true
# Generated via `rails generate hyrax:work Image`
require 'rails_helper'

RSpec.describe Image do

  it_behaves_like 'a work with facetable years'

  it "requires a title" do
    image = Image.new
    image.description = ["test description"]
    image.date_created = ["1934"]
    image.subject = ["Medicine"]
    expect(image.save).to eq false
    image.title = ["test"]
    expect(image.save).to eq true
  end

  it "requires a description" do
    image = Image.new
    image.title = ["test"]
    image.date_created = ["1934"]
    image.subject = ["Medicine"]
    expect(image.save).to eq false
    image.description = ["test description"]
    expect(image.save).to eq true
  end

  it "requires a date_created" do
    image = Image.new
    image.title = ["test"]
    image.description = ["test description"]
    image.subject = ["Medicine"]
    expect(image.save).to eq false
    image.date_created = ["1934"]
    expect(image.save).to eq true
  end

  it "requires a subject" do
    image = Image.new
    image.title = ["test"]
    image.description = ["test description"]
    image.date_created = ["1934"]
    expect(image.save).to eq false
    image.subject = ["Medicine"]
    expect(image.save).to eq true
  end

  it "requires at_location if resource_type is 'Artifact'" do
    image = Image.new
    image.title = ["test"]
    image.description = ["test description"]
    image.date_created = ["1934"]
    image.subject = ["Medicine"]
    image.resource_type = ["Artifact"]
    expect(image.save).to eq false
    image.at_location = ["Room 222"]
    #expect(image.save).to eq true
  end

  it "requires host_organization if resource_type is 'Poster'" do
    image = Image.new
    image.title = ["test"]
    image.description = ["test description"]
    image.date_created = ["1934"]
    image.subject = ["Medicine"]
    image.resource_type = ["Poster"]
    expect(image.save).to eq false
    image.host_organization = ["CDC"]
    expect(image.save).to eq true
  end

  it "requires host_organization if resource_type is 'Presentation'" do
    image = Image.new
    image.title = ["test"]
    image.description = ["test description"]
    image.date_created = ["1934"]
    image.subject = ["Medicine"]
    image.resource_type = ["Presentation"]
    expect(image.save).to eq false
    image.host_organization = ["Duke University"]
    expect(image.save).to eq true
  end

  it "can add a holding entity" do
    image = Image.new
    expect(image.holding_entity).to be_empty
    image.holding_entity = ["my location"]
    expect(image.holding_entity.first).to eq "my location"
    expect(image.resource.dump(:ttl)).to match(/www.loc.gov\/mods\/rdf\/v1#locationPhysical/)
  end

    it "can add a sorting date" do
      image = Image.new
      expect(image.date).to be_empty
      image.date = ["1973-04-09"]
      expect(image.date.first).to eq "1973-04-09"
      #expect(image.resource.dump(:ttl)).to match(/www.loc.gov\/mods\/rdf\/v1#locationPhysical/)
    end

    it "can add an archival collection" do
      image = Image.new
      expect(image.archival_collection).to be_empty
      image.archival_collection = ["DUMC Archives"]
      expect(image.archival_collection.first).to eq "DUMC Archives"
      #expect(image.resource.dump(:ttl)).to match(/www.loc.gov\/mods\/rdf\/v1#locationPhysical/)
    end

    it "can add an admin date" do
      image = Image.new
      expect(image.date_accepted).to be_empty
      image.date_accepted = ["1973-04-09"]
      expect(image.date_accepted.first).to eq "1973-04-09"
      #expect(image.resource.dump(:ttl)).to match(/www.loc.gov\/mods\/rdf\/v1#locationPhysical/)
    end

    it "can add an admin condition" do
      image = Image.new
      expect(image.condition).to be_empty
      image.condition = ["Broken Lid"]
      expect(image.condition.first).to eq "Broken Lid"
      #expect(image.resource.dump(:ttl)).to match(/www.loc.gov\/mods\/rdf\/v1#locationPhysical/)
    end

    it "can add a type of donation" do
      image = Image.new
      expect(image.accrual_method).to be_empty
      image.accrual_method = ["Gift"]
      expect(image.accrual_method.first).to eq "Gift"
      #expect(image.resource.dump(:ttl)).to match(/www.loc.gov\/mods\/rdf\/v1#locationPhysical/)
    end

    it "can add a provenance" do
      image = Image.new
      expect(image.provenance).to be_empty
      image.provenance = ["Found at Auction"]
      expect(image.provenance.first).to eq "Found at Auction"
      #expect(image.resource.dump(:ttl)).to match(/www.loc.gov\/mods\/rdf\/v1#locationPhysical/)
    end

    it "can add a room location" do
      image = Image.new
      expect(image.based_near).to be_empty
      image.based_near = ["Room 102"]
      expect(image.based_near.first).to eq "Room 102"
      #expect(image.resource.dump(:ttl)).to match(/www.loc.gov\/mods\/rdf\/v1#locationPhysical/)
    end

end
