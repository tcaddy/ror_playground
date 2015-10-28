require 'rails_helper'

RSpec.describe Album, type: :model do
  it 'has a factory for testing' do
    expect(build(:album)).to be_valid
    expect(build(:album_full)).to be_valid
  end

  let(:album) { build(:album) }
  let(:album_full) { build(:album_full) }
  let(:album_bad_photo_url) { build(:album, photo_url: Faker::Lorem.word) }
  let(:album_good_year) { build(:album, year: Time.zone.today.year) }
  describe 'ActiveModel validations' do
    it { expect(album).to validate_presence_of(:name) }
    it { expect(album).to validate_uniqueness_of(:name).scoped_to(:artist_id) }
    it { expect(album_bad_photo_url).not_to be_valid }

    # Note: We cannot create a test case with an invalid :year
    # because the :year attribute gets rewritten as zero if we
    # try to assign an alpha value.  Let's at least explicity validate
    # a good :year, even though the :album_full Factory kinda does this.
    it { expect(album_good_year).to be_valid }
  end

  describe 'ActiveRecord associations' do
    it { expect(album).to belong_to(:artist) }
    it { expect(album).to have_many(:songs) }
  end

  describe 'scopes' do
    before(:each) do
      4.times do
        artist_id = create(:artist).id
        4.times do
          create(:album, artist_id: artist_id)
        end
      end
    end
    it '.for_select returns options for select, with artist name, sorted by artist/album name' do
      # 4.times do
      #   artist = create(:artist)
      #   4.times do
      #     create(:album, artist_id: artist.id)
      #   end
      # end
      result = Album.for_select
      i = -1
      Artist.all.order(:name).each do |artist|
        artist.albums.all.order(:name).each do |album|
          expect(result[i += 1]).to eq(album)
        end
      end
    end
  end

  describe 'public instance methods' do
    context 'responds to its methods' do
      it { expect(album).to respond_to(:artist_album_name) }
    end

    context 'executes methods correctly' do
      context '#artist_album_name' do
        it 'does what it\'s supposed to...' do
          expect(album.artist_album_name).to eq("#{album.artist.name} - #{album.name}")
        end
      end
    end
  end
end
