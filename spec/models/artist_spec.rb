require 'rails_helper'

RSpec.describe Artist, type: :model do
  it "has a factory for testing" do
    expect(build(:artist)).to be_valid
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
