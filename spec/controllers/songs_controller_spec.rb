require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.
RSpec.describe SongsController, type: :controller do
  # This should return the minimal set of attributes required to create a valid
  # Song. As you add validations to Song, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { attributes_for(:song) }

  let(:invalid_attributes) { attributes_for(:song, name: nil) }

  let(:attributes_with_string_duration) { attributes_for(:song, duration: '1:23') }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # SongsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'assigns all songs as @songs' do
      song = Song.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:songs)).to eq([song])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested song as @song' do
      song = Song.create! valid_attributes
      get :show, {id: song.to_param}, valid_session
      expect(assigns(:song)).to eq(song)
    end
  end

  describe 'GET #new' do
    login_user
    it 'assigns a new song as @song' do
      get :new, {}, valid_session
      expect(assigns(:song)).to be_a_new(Song)
    end
  end

  describe 'GET #edit' do
    login_user
    it 'assigns the requested song as @song' do
      song = Song.create! valid_attributes
      get :edit, {id: song.to_param}, valid_session
      expect(assigns(:song)).to eq(song)
    end
  end

  describe 'POST #create' do
    login_user
    context 'with valid params' do
      it 'creates a new Song' do
        expect do
          post :create, {song: valid_attributes}, valid_session
        end.to change(Song, :count).by(1)
      end

      it 'assigns a newly created song as @song' do
        post :create, {song: valid_attributes}, valid_session
        expect(assigns(:song)).to be_a(Song)
        expect(assigns(:song)).to be_persisted
      end

      it 'redirects to the created song' do
        post :create, {song: valid_attributes}, valid_session
        expect(response).to redirect_to(Song.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved song as @song' do
        post :create, {song: invalid_attributes}, valid_session
        expect(assigns(:song)).to be_a_new(Song)
      end

      it 're-renders the :new template' do
        post :create, {song: invalid_attributes}, valid_session
        expect(response).to render_template('new')
      end
    end

    context 'with string :duration' do
      it 'parses the string and assigns an integer' do
        post :create, {song: attributes_with_string_duration}, valid_session
        expect(Song.last.duration).to eq(83)
      end
    end
  end

  describe 'PUT #update' do
    login_user
    context 'with valid params' do
      let(:new_attributes) { attributes_for(:song) }

      it 'updates the requested song' do
        old_attributes = valid_attributes
        song = Song.create! old_attributes
        cached_new_attributes = new_attributes
        put :update, {id: song.to_param, song: cached_new_attributes}, valid_session
        song.reload
        cached_new_attributes.each do |k, v|
          expect(song[k]).to eq(v)
        end
      end

      it 'assigns the requested song as @song' do
        song = Song.create! valid_attributes
        put :update, {id: song.to_param, song: valid_attributes}, valid_session
        expect(assigns(:song)).to eq(song)
      end

      it 'redirects to the song' do
        song = Song.create! valid_attributes
        put :update, {id: song.to_param, song: valid_attributes}, valid_session
        expect(response).to redirect_to(song)
      end
    end

    context 'with invalid params' do
      it 'assigns the song as @song' do
        song = Song.create! valid_attributes
        put :update, {id: song.to_param, song: invalid_attributes}, valid_session
        expect(assigns(:song)).to eq(song)
      end

      it 're-renders the :edit template' do
        song = Song.create! valid_attributes
        put :update, {id: song.to_param, song: invalid_attributes}, valid_session
        expect(response).to render_template('edit')
      end
    end

    context 'with string :duration' do
      it 'parses the string and assigns an integer' do
        song = Song.create! valid_attributes
        put :update, {id: song.to_param, song: attributes_with_string_duration}, valid_session
        song.reload
        expect(song.duration).to eq(83)
      end
    end
  end

  describe 'DELETE #destroy' do
    login_user
    it 'destroys the requested song' do
      song = Song.create! valid_attributes
      expect do
        delete :destroy, {id: song.to_param}, valid_session
      end.to change(Song, :count).by(-1)
    end

    it 'redirects to the songs list' do
      song = Song.create! valid_attributes
      delete :destroy, {id: song.to_param}, valid_session
      expect(response).to redirect_to(songs_url)
    end
  end
end
