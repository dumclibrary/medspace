# Generated via
#  `rails generate hyrax:work Publication`
require 'rails_helper'

RSpec.describe Publication do
  it "can add a holding entity" do
    pub = Publication.new
    expect(pub.holding_entity).to be_empty
    pub.holding_entity = ["my location"]
    expect(pub.holding_entity.first).to eq "my location"
    expect(pub.resource.dump(:ttl)).to match(/www.loc.gov\/mods\/rdf\/v1#locationPhysical/)
  end
end
