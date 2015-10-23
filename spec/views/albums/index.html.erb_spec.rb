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
        key=:artist_id if key==:artist
        assert_select "tr[data-row-id='#{album.id}']>td",text: album[key].to_s, count:1
      end
    end
  end
end
