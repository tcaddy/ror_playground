require 'rails_helper'

RSpec.describe "albums/new", type: :view do
  before(:each) do
    assign(:album, Album.new(
      :artist_id => 1,
      :name => "MyString",
      :year => 1,
      :photo_url => "MyString"
    ))
  end

  it "renders new album form" do
    render

    assert_select "form[action=?][method=?]", albums_path, "post" do

      assert_select "input#album_artist_id[name=?]", "album[artist_id]"

      assert_select "input#album_name[name=?]", "album[name]"

      assert_select "input#album_year[name=?]", "album[year]"

      assert_select "input#album_photo_url[name=?]", "album[photo_url]"
    end
  end
end
