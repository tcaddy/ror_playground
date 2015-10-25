require 'rails_helper'

RSpec.describe "artists/edit", type: :view do
  before(:each) do
    @artist = assign(:artist, create(:artist))
  end

  it "renders the edit artist form" do
    render

    assert_select "form[action=?][method=?]", artist_path(@artist), "post" do

      assert_select "input#artist_name[name=?].form-control", "artist[name]"

      assert_select "input[type='submit'][data-disable-with='Saving...'].btn-primary"
    end
  end
end
