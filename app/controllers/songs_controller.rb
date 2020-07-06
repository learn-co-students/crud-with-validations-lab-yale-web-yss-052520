class SongsController < ApplicationController

    before_action :find_song, only: [:show, :edit, :update, :destroy]

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
            render 'new'
        end
    end

    def edit

    end

    def update
        @song.attributes = song_params
        if @song.valid?
            @song.save
            redirect_to song_path(@song)
        else
            flash[:errors] = @song.errors.full_messages
            render 'edit'
        end
    end

    def destroy
        @song.delete
        redirect_to songs_path 
    end

    private

    def find_song
        @song = Song.find(params[:id])
    end

    def song_params
        params.require(:song).permit(:title, :released, :release_year, :artist_name, :genre)
    end
end
