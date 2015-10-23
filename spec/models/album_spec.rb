require 'rails_helper'

RSpec.describe Album, type: :model do
  it "has a factory for testing" do
    expect(build(:album)).to be_valid
    expect(build(:album_full)).to be_valid
  end
  it { is_expected.to validate_presence_of(:name) }

  let(:album) {build(:album)}
  let(:album_full) {build(:album_full)}
  let(:album_bad_photo_url) {build(:album,photo_url: Faker::Lorem.word)}
  let(:album_good_year) {build(:album,year: Date.today.year)}
  describe "ActiveModel validations" do
    it { expect(album).to validate_presence_of(:name) }
    it { expect(album_bad_photo_url).not_to be_valid}

    # Note: We cannot create a test case with an invalid :year
    # because the :year attribute gets rewritten as zero if we
    # try to assign an alpha value.  Let's at least explicity validate
    # a good :year, even though the :album_full Factory kinda does this.
    it { expect(album_good_year).to be_valid}
  end

  describe "ActiveRecord associations" do
    it { expect(album).to belong_to(:artist) }
  end
end
