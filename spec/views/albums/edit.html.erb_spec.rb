require 'rails_helper'

RSpec.describe "albums/edit", type: :view do
  before(:each) do
    @album = assign(:album, Album.create!(
      :artist_id => 1,
      :name => "MyString",
      :year => 1,
      :photo_url => "MyString"
    ))
  end

  it "renders the edit album form" do
    render

    assert_select "form[action=?][method=?]", album_path(@album), "post" do

      assert_select "input#album_artist_id[name=?]", "album[artist_id]"

      assert_select "input#album_name[name=?]", "album[name]"

      assert_select "input#album_year[name=?]", "album[year]"

      assert_select "input#album_photo_url[name=?]", "album[photo_url]"
    end
  end
end
