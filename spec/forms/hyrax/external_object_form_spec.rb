# Generated via
#  `rails generate hyrax:work ExternalObject`
require 'rails_helper'

RSpec.describe Hyrax::ExternalObjectForm do
  subject { form }
  let(:exo)     { ExternalObject.new }
  let(:ability) { Ability.new(nil) }
  let(:request) { nil }
  let(:form)    { described_class.new(exo, ability, request) }
  it "has the expected terms" do
    expect(form.terms).to include(:title)
    expect(form.terms).to include(:holding_entity)
    expect(form.terms).to include(:archival_collection)
    expect(form.terms).to include(:date)
  end
end
