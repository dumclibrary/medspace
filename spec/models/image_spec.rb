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
end
