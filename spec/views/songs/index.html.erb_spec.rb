require 'rails_helper'

RSpec.describe "songs/index", type: :view do
  before(:each) do
    @songs = Kaminari.paginate_array([
      create(:song_full),
      create(:song_full)
    ]).page(1)
  end

  it "renders a list of songs" do
    render
    @songs.each do |song|
      assert_select "tr[data-row-id='#{song.id}']" do
        assert_select "td a[href='#{url_for(song.album)}']", text: song.album.name
        assert_select "td", text: song.name
        assert_select "td[data-attr='track']", text: song.track.to_s
        assert_select "td[data-attr='disk']", text: song.disk.to_s
        assert_select "td", text: song_duration(song.duration)
      end
    end
  end
end
