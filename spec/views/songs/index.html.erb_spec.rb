require 'rails_helper'

RSpec.describe "songs/index", type: :view do
  before(:each) do
    assign(:songs, [
      Song.create!(
        :album_id => 1,
        :name => "Name",
        :track => 2,
        :disk => 3,
        :duration => 4
      ),
      Song.create!(
        :album_id => 1,
        :name => "Name",
        :track => 2,
        :disk => 3,
        :duration => 4
      )
    ])
  end

  it "renders a list of songs" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
  end
end
