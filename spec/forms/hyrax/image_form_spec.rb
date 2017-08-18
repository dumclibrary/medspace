# Generated via
#  `rails generate hyrax:work Image`
require 'rails_helper'

RSpec.describe Hyrax::ImageForm do
  subject { form }
  let(:image)     { Image.new }
  let(:ability) { Ability.new(nil) }
  let(:request) { nil }
  let(:form)    { described_class.new(image, ability, request) }
  it "has the expected terms" do
    expect(form.terms).to include(:title)
    expect(form.terms).to include(:holding_entity)
    expect(form.terms).to include(:date)
    expect(form.terms).to include(:archival_collection)
    expect(form.terms).to include(:date_accepted)
    expect(form.terms).to include(:condition)
    expect(form.terms).to include(:accrual_method)
    expect(form.terms).to include(:provenance)
  end
end
