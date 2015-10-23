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
      expected_value = if col=="Photo Url"
        "Photo"
      else
        col
      end
      assert_select "thead>tr>th",text:expected_value,count:1
    end

    @albums.each do |album|
      attrs.each do |key|
        expected_value = (if key==:artist
          album.artist.name
        elsif key==:photo_url
          nil
        else
          album[key]
        end).to_s
        sel_string = if key==:photo_url
          "tr[data-row-id='#{album.id}']>td>img[src='#{album.photo_url}']"
        else
          "tr[data-row-id='#{album.id}']>td"
        end
        assert_select sel_string,text: expected_value, count:1
      end
    end
  end
end
