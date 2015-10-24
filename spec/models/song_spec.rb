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

  describe "public class methods" do
    context "responds to its methods" do
      it { expect(Song).to respond_to(:parse_duration) }
    end

    context "executes methods correctly" do
      context "Song.parse_duration" do
        it "does what it's supposed to..." do
          [
            {
              string: "0:01",
              integer: 1
            },
            {
              string: "1:05",
              integer: 65
            },
            {
              string: "10:05",
              integer: 605
            },
            {
              string: "1:01:01",
              integer: 3661
            }
          ].each do |h|
            expect(Song.parse_duration(h[:string])).to eq(h[:integer])
          end
        end
      end
    end
  end
end
