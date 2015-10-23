require 'rails_helper'

RSpec.describe "albums/index", type: :view do
  before(:each) do
    @albums = [
      create(:album_full),
      create(:album_full)
    ]
  end

  let(:attrs) {[:artist,:name,:year,:photo_url]}

  it "renders a list of albums" do
    render
    attrs.map{|c| c.to_s.titleize}.each do |col|
      assert_select "thead>tr>th",text:col,count:1
    end

    @albums.each do |album|
      attrs.each do |key|
        expected_value = (if key==:artist
          album.artist.name
        else
          album[key]
        end).to_s
        assert_select "tr[data-row-id='#{album.id}']>td",text: expected_value, count:1
      end
    end
  end
end
