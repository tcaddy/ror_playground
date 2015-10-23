require 'rails_helper'

RSpec.describe "albums/index", type: :view do
  before(:each) do
    assign(:albums, [
      Album.create!(
        :artist_id => 1,
        :name => "Name",
        :year => 2,
        :photo_url => "Photo Url"
      ),
      Album.create!(
        :artist_id => 1,
        :name => "Name",
        :year => 2,
        :photo_url => "Photo Url"
      )
    ])
  end

  it "renders a list of albums" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Photo Url".to_s, :count => 2
  end
end
