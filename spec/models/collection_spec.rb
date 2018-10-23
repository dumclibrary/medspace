require 'rails_helper'

RSpec.describe Collection do

  it "requires a title" do
    coll = Collection.new
    expect(coll.save).to eq false
    coll.title = ["test"]
    # expect(coll.save).to eq true
  end

end
