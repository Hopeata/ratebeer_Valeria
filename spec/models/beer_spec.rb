require 'rails_helper'

describe Beer do
  it "with proper name and style" do
    beer = Beer.create name:"Humala", style:"Weizen"
    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end

  it "is not saved without a name" do
    beer = Beer.create style:"Weizen"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is not saved without a style" do
    beer = Beer.create name:"Humala"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

end

#RSpec.describe Beer, type: :model do
#  pending "add some examples to (or delete) #{__FILE__}"
#end
