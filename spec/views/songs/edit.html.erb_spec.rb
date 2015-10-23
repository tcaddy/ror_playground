require 'rails_helper'

RSpec.describe "songs/edit", type: :view do
  before(:each) do
    @song = assign(:song, Song.create!(
      :album_id => 1,
      :name => "MyString",
      :track => 1,
      :disk => 1,
      :duration => 1
    ))
  end

  it "renders the edit song form" do
    render

    assert_select "form[action=?][method=?]", song_path(@song), "post" do

      assert_select "input#song_album_id[name=?]", "song[album_id]"

      assert_select "input#song_name[name=?]", "song[name]"

      assert_select "input#song_track[name=?]", "song[track]"

      assert_select "input#song_disk[name=?]", "song[disk]"

      assert_select "input#song_duration[name=?]", "song[duration]"
    end
  end
end