require 'rails_helper'

RSpec.describe 'artists/index', type: :view do
  context 'regular listing' do
    before(:each) do
      @artists = Kaminari.paginate_array([
        create(:artist),
        create(:artist)
      ]).page(1)
    end

    it 'renders a list of artists' do
      render
      assert_select 'div.table-responsive table.table-striped' do
        @artists.each do |artist|
          assert_select "tr[data-row-id='#{artist.id}']", count: 1 do
            assert_select "td[data-attr='name'] a[href='#{url_for(artist)}']", text: artist.name
            assert_select "td a[href='#{url_for(artist)}'][data-method='delete'] span.glyphicon-remove"
          end
        end
      end
    end
  end

  context 'with empty database table' do
    before(:each) do
      @artists = Kaminari.paginate_array([]).page(1)
    end
    it 'renders a jumbotron' do
      render
      assert_select '.jumbotron'
      assert_select "a[href='#{new_artist_path}']"
    end
  end
end
