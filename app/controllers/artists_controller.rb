# Artist controller
class ArtistsController < ApplicationController
  before_action :set_artist, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:new, :create]
  before_action :throttle_new_before_action, only: [:new, :create]
  before_action :delete_old_records, only: [:index]

  # GET /artists
  # GET /artists.json
  def index
    @artists = Artist.all.order(:name).page params[:page]
  end

  # GET /artists/1
  # GET /artists/1.json
  def show
  end

  # GET /artists/new
  def new
    @artist = Artist.new
  end

  # GET /artists/1/edit
  def edit
  end

  # POST /artists
  # POST /artists.json
  def create
    @artist = Artist.new(artist_params)

    respond_to do |format|
      if @artist.save
        @artist.send :seed_from_spotify
        @artist.reload
        format.html { redirect_to @artist, notice: 'Artist was successfully created.' }
        format.json { render :show, status: :created, location: @artist }
      else
        format.html { render :new }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /artists/1
  # PATCH/PUT /artists/1.json
  def update
    respond_to do |format|
      if @artist.update(artist_params)
        format.html { redirect_to @artist, notice: 'Artist was successfully updated.' }
        format.json { render :show, status: :ok, location: @artist }
      else
        format.html { render :edit }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /artists/1
  # DELETE /artists/1.json
  def destroy
    @artist.destroy
    respond_to do |format|
      format.html { redirect_to artists_url, notice: 'Artist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_artist
    @artist = Artist.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def artist_params
    params.require(:artist).permit(:name)
  end

  def throttle_new_before_action
    # limit creation from users who are not logged in to 1 per minute
    return if user_signed_in? || Artist.created_in_last_minute.count == 0
    redirect_to artists_url, notice: 'Artist creation limited to one new artist per minute.' and return
  end

  # Heroku doesn't have cron and makes you give them a credit card to run
  # tasks on their scheduler.
  # I would prefer to run something like this overnight.
  # This is a free alternative to running it on a schedule.
  def delete_old_records
    Artist.over_1_day_old.destroy_all
  end
end
