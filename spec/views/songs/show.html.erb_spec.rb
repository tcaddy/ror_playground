require 'rails_helper'

RSpec.describe "songs/show", type: :view do
  before(:each) do
    @song = assign(:song, create(:song))
  end

  it "renders attributes in <p>" do
    render
    expect(response).to render_template("shared/_notice")
    assert_select "dl[data-attr='name']>dd", text: @song.name
    assert_select "dl[data-attr='album']>dd a[href='#{url_for(@song.album)}']", text: @song.album.name
    assert_select "dl[data-attr='track']>dd", text: @song.track.to_s
    assert_select "dl[data-attr='disk']>dd", text: @song.disk.to_s
    assert_select "dl[data-attr='duration']>dd", text: song_duration(@song.duration)
  end
end
