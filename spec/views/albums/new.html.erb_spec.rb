require 'rails_helper'

RSpec.describe "albums/new", type: :view do
  before(:each) do
    assign(:album, build(:album))
  end

  it "renders new album form" do
    render

    assert_select "form[action=?][method=?]", albums_path, "post" do

      assert_select "select#album_artist_id[name=?]", "album[artist_id]"

      assert_select "input#album_name[name=?]", "album[name]"

      assert_select "input#album_year[name=?]", "album[year]"

      assert_select "input#album_photo_url[name=?]", "album[photo_url]"

      assert_select "input[type='submit'][data-disable-with='Saving...']"
    end
  end
end
