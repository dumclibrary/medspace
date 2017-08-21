# Generated via
#  `rails generate hyrax:work Document`
require 'rails_helper'

RSpec.describe Hyrax::DocumentForm do
  subject { form }
  let(:doc)     { Document.new }
  let(:ability) { Ability.new(nil) }
  let(:request) { nil }
  let(:form)    { described_class.new(doc, ability, request) }
  it "has the expected terms" do
    expect(form.terms).to include(:title)
    expect(form.terms).to include(:holding_entity)
    expect(form.terms).to include(:date)
    expect(form.terms).to include(:archival_collection)
    expect(form.terms).to include(:host_organization)

  end
end
