# Generated via
#  `rails generate hyrax:work Image`
require 'rails_helper'

RSpec.describe Image do

  it "requires a title" do
    image = Image.new
    expect(image.save).to eq false
    image.title = ["test"]
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
      expect(image.accural_method).to be_empty
      image.accural_method = ["Gift"]
      expect(image.accural_method.first).to eq "Gift"
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
