require 'rails_helper'

RSpec.describe 'artists/new', type: :view do
  before(:each) do
    assign(:artist, build(:artist))
  end

  it 'renders new artist form' do
    render

    assert_select 'form[action=?][method=?]', artists_path, 'post' do
      assert_select 'input#artist_name[name=?].form-control', 'artist[name]'
      assert_select 'input[type=submit][data-disable-with="Saving..."].btn-primary'
    end
  end
end
