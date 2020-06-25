class SongsController < ApplicationController
    before_action :current_song, only: [:edit, :update, :show, :destroy]

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
    # byebug
        # if @song.valid?
        #     @song.save
        #     redirect_to song_path(@song)
        # else 
        #     render :new
        # end

        if @song.save
            # byebug
            redirect_to song_path(@song)
        else
            render :new
        end
    end 

    def edit
    end

    def update
        @song.update(song_params)
        if @song.valid?
            @song.save
            redirect_to song_path(@song)
        else
          render :edit
        end
    end

    def destroy 
        @song.destroy
        redirect_to songs_path
    end

private
    def current_song 
        @song = Song.find(params[:id])
    end

    def song_params
        params.require(:song).permit(:title, :genre, :artist_name, :released, :release_year)
    end
end