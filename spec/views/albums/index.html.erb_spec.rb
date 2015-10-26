require 'rails_helper'

RSpec.describe "albums/index", type: :view do
  before(:each) do
    @albums = Kaminari.paginate_array([
      create(:album_full),
      create(:album_full)
    ]).page(1)
  end

  let(:attrs) {[:artist,:name,:year,:photo_url]}

  it "renders a list of albums" do
    render
    assert_select "div.table-responsive table.table-striped" do
      attrs.map{|c| c.to_s.titleize}.each do |col|
        expected_value = if col=="Photo Url"
          "Photo"
        else
          col
        end
        assert_select "thead>tr>th",text:expected_value,count:1
      end

      @albums.each do |album|
        assert_select "tr[data-row-id='#{album.id}']" do
          attrs.each do |key|
            expected_value = (if key==:artist
              album.artist.name
            elsif key==:photo_url
              nil
            else
              album[key]
            end).to_s
            sel_string = ["td[data-attr='#{key}']", (case key
              when :photo_url
                "img[src='#{album.photo_url}']"
              when :name
                "a[href='#{url_for(album)}']"
              when :artist
                "a[href='#{url_for(album.artist)}']"
              else nil
            end)].compact.join(' ')
            assert_select sel_string,text: expected_value, count:1
          end
          assert_select "td a[href='#{url_for(album)}'][data-method='delete'] span.glyphicon-remove"
        end
      end
    end
  end
end
