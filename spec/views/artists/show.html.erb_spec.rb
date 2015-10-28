require 'rails_helper'

RSpec.describe 'artists/show', type: :view do
  before(:each) do
    @artist = assign(:artist, create(:artist))
    2.times do
      create(:album, artist_id: @artist.id)
    end
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/#{ERB::Util.html_escape @artist.name}/)

    assert_select 'dl[data-attr=name]>dd', text: @artist.name

    assert_select 'dl[data-attr=albums]>dd ul.artist-albums' do
      @artist.albums.each do |album|
        assert_select "a[href='#{url_for(album)}']", text: album.name
      end
    end
  end
end
