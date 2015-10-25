require 'rails_helper'

RSpec.describe "albums/edit", type: :view do
  before(:each) do
    @album = assign(:album, create(:album))
  end

  it "renders the edit album form" do
    render

    assert_select "form[action=?][method=?]", album_path(@album), "post" do

      assert_select "select#album_artist_id[name=?].form-control", "album[artist_id]"

      assert_select "input#album_name[name=?].form-control", "album[name]"

      assert_select "input#album_year[name=?].form-control", "album[year]"

      assert_select "input#album_photo_url[name=?].form-control", "album[photo_url]"

      assert_select "input[type='submit'][data-disable-with='Saving...'].btn-primary"
    end
  end
end
