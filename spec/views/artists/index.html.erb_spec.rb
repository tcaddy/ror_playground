require 'rails_helper'

RSpec.describe "artists/index", type: :view do
  before(:each) do
    @artists = [
      create(:artist),
      create(:artist)
    ]
  end

  it "renders a list of artists" do
    render
    @artists.each do |artist|
      assert_select "tr[data-row-id='#{artist.id}'] td", text: artist.name, count:1
    end
  end
end
