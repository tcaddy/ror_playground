require 'rails_helper'

RSpec.describe Artist, type: :model do
  it "has a factory for testing" do
    expect(build(:artist)).to be_valid
  end

  let(:artist) { build(:artist) }
  describe "ActiveModel validations" do
    it { expect(artist).to validate_presence_of(:name) }
    it { expect(artist).to validate_uniqueness_of(:name) }
  end

  describe "ActiveRecord associations" do
    it { expect(artist).to have_many(:albums) }
  end

  describe "public class methods" do
    context "responds to its methods" do
      it { expect(Artist).to respond_to(:seed_artists_from_spotify) }
    end

    context "executes methods correctly" do
      context "Artist.seed_artists_from_spotify" do
        let(:artist_names) { %w(Phish) }
        it "creates and populates new artists" do
          expect(Artist.where(["name in (?)",artist_names]).count).to eq(0)
          Artist.seed_artists_from_spotify(artist_names)
          artist_names.each do |artist_name|
            artist = Artist.where(name: artist_name).first
            expect(artist).to be_an(Artist)
            expect(artist.albums.count).to be > 0
            artist.albums.each do |album|
              expect(album.songs.count).to be > 0
            end
          end
        end
      end
    end
  end
end
