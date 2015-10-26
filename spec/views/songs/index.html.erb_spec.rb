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
    assert_select "div.table-responsive table.table-striped" do
      @songs.each do |song|
        assert_select "tr[data-row-id='#{song.id}']" do
          assert_select "td[data-attr='album'] a[href='#{url_for(song.album)}']", text: song.album.name
          assert_select "td[data-attr='name'] a[href='#{url_for(song)}']", text: song.name
          assert_select "td[data-attr='track']", text: song.track.to_s
          assert_select "td[data-attr='disk']", text: song.disk.to_s
          assert_select "td[data-attr='duration']", text: song_duration(song.duration)
          assert_select "td a[href='#{url_for(song)}'][data-method='delete'] span.glyphicon-remove"
        end
      end
    end
  end
end
