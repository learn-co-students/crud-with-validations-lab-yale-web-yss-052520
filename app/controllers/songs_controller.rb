class SongsController < ApplicationController
    before_action :current_song, only: [:show, :edit, :update, :destroy]

    def index
        @songs = Song.all
    end

    def show
        # binding.pry
    end

    def new
        @song = Song.new
    end

    def create
        @song = Song.create(song_params)
        if @song.id
            redirect_to song_path(@song)
        else
            render "new"
        end
    end

    def edit
    end

    def update
        # binding.pry
        @song.assign_attributes(song_params)
        if @song.valid?
            @song.save
            redirect_to song_path(@song)
        else
            render "edit"
        end
    end

    def destroy
        @song.destroy
        redirect_to songs_path
    end

    private

    def current_song
        # binding.pry
        @song = Song.find(params[:id])
    end

    def song_params
        params.require(:song).permit(:title, :released, :release_year, :artist_name, :genre)
    end
end
