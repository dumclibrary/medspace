# Generated via
#  `rails generate hyrax:work ExternalObject`
require 'rails_helper'

RSpec.describe ExternalObject do
  it "can add a holding entity" do
    exo = ExternalObject.new
    expect(exo.holding_entity).to be_empty
    exo.holding_entity = ["my location"]
    expect(exo.holding_entity.first).to eq "my location"
    expect(exo.resource.dump(:ttl)).to match(/www.loc.gov\/mods\/rdf\/v1#locationPhysical/)
  end
end
