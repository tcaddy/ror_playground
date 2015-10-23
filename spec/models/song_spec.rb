require 'rails_helper'

RSpec.describe Song, type: :model do
  it "has a factory for testing" do
    expect(build(:song)).to be_valid
    expect(build(:song_full)).to be_valid
  end

  let(:song) {build(:song)}
  let(:song_full) {build(:song_full)}
  describe "ActiveModel validations" do
    it { expect(song).to validate_presence_of(:name) }


  end

  describe "ActiveRecord associations" do
    it { expect(song).to belong_to(:album) }
  end
end
