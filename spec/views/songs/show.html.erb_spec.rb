require 'rails_helper'

RSpec.describe "songs/show", type: :view do
  before(:each) do
    @song = assign(:song, create(:song))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/#{@song.name}/)
    assert_select "a[href='#{url_for(@song.album)}']", text: @song.album.name
    expect(rendered).to match(/#{@song.track}/)
    expect(rendered).to match(/#{@song.disk}/)
    expect(rendered).to match(/#{song_duration @song.duration}/)
  end
end
