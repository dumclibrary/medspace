# Generated via
#  `rails generate hyrax:work Image`
require 'rails_helper'

RSpec.describe Image do
  it "can make an image" do
    i = Image.new
    i.save
    expect(i).to be_instance_of(Image)
  end

  it "can add a title" do
    i = Image.new
    i.title = ["Test Title"]
    i.save
    expect(i.title.first).to eq "Test Title"
    # puts i.resource.dump(:ttl)
    # <http://purl.org/dc/terms/title> "Test Title";
    expect(i.resource.dump(:ttl)).to match(/purl.org\/dc\/terms\/title/)
  end

  it "requires a title" do
    image = Image.new
    expect(image.save).to eq false
    image.title = ["test"]
    expect(image.save).to eq true
  end
end
