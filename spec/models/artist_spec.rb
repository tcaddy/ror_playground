require 'rails_helper'

RSpec.describe Artist, type: :model do
  it "has a factory for testing" do
    expect(build(:artist)).to be_valid
  end
  it { is_expected.to validate_presence_of(:name) }

  let(:artist) { build(:artist) }
  describe "ActiveModel validations" do
    it { expect(artist).to validate_presence_of(:name) }
  end

  describe "ActiveRecord associations" do
    it { expect(artist).to have_many(:albums) }
  end
end
