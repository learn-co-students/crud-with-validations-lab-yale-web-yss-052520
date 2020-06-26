class SongsController < ApplicationController
  before_action :set_song!, only: [:show, :edit, :update, :destroy]

  def index
    @songs = Song.all
  end

  def show
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)

    if @song.valid?
      @song.save
      redirect_to song_path(@song)
    else
      flash[:errors] = @song.errors.full_messages
      #redirect_to new_song_path
      render :new
    end

  end

  def edit

  end

  def update

    @song.assign_attributes(song_params)
    if @song.valid?
      @song.save
      redirect_to song_path(@song)
    else
      flash[:errors] = @song.errors.full_messages
      #redirect_to edit_song_path
      render :edit
    end

  end

  def destroy
    @song.destroy
    redirect_to songs_path
  end


  private

  def set_song!
    @song = Song.find(params[:id])
  end

  def song_params
    params.require(:song).permit(:title, :genre, :artist_name, :released, :release_year)
  end


end
