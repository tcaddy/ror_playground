require 'rails_helper'

RSpec.describe "albums/show", type: :view do
  before(:each) do
    @album = assign(:album, create(:album))
  end

  let(:attrs) {[:artist_id,:name,:year,:photo_url]}
  it "renders attributes in <p>" do
    render
    attrs.each do |attr|
      expect(rendered).to match(/#{@album[attr]}/)
    end
  end
end
