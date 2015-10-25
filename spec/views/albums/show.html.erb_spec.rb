require 'rails_helper'

RSpec.describe "albums/show", type: :view do
  before(:each) do
    @album = assign(:album, create(:album))
  end

  let(:attrs) {[:artist_id,:name,:year,:photo_url]}
  it "renders attributes in <p>" do
    render
    expect(response).to render_template("shared/_notice")
    attrs.each do |attr|
      expected_value = if attr==:artist_id
        Artist.find(@album[attr]).name
      else
        @album[attr]
      end
      assert_select "dl[data-attr='#{attr.to_s.chomp('_id')}']>dd", text: ERB::Util.html_escape(expected_value)
    end

    assert_select "dl[data-attr='songs']>dd>ul.album-songs" do
      @album.songs.each do |song|
        expected_text = song.disk.blank? ? "" : "#{song.disk} - "
        expected_text += "#{"%02d" % song.track} - #{song.name}"
        assert_select "li[data-song-id='#{song.id}']", text: expected_text do
          assert_select "a[href='#{url_for(song)}']", text: song.name
        end
      end
    end

  end
end
