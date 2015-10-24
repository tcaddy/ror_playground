require 'rails_helper'

RSpec.describe "songs/new", type: :view do
  before(:each) do
    @song = assign(:song, build(:song_full))
  end

  it "renders new song form" do
    render

    assert_select "form[action=?][method=?]", songs_path, "post" do

      assert_select "select#song_album_id[name=?]", "song[album_id]"

      assert_select "input#song_name[name=?]", "song[name]"

      assert_select "input#song_track[name=?]", "song[track]"

      assert_select "input#song_disk[name=?]", "song[disk]"

      assert_select "input#song_duration[name=?][value=?]", "song[duration]",Song.song_duration(@song.duration)

      assert_select "input[type='submit'][data-disable-with='Saving...']"
    end
  end
end
