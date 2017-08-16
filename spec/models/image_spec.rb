# Generated via
#  `rails generate hyrax:work Image`
require 'rails_helper'

RSpec.describe Image do
  it "can make an image" do
    i = Image.new
    i.save
    expect(i).to be_instance_of(Image)
  end
end
