class SongsController < ApplicationController

    def index
        @songs = Song.all
    end

    def show
        @song = Song.find(params[:id])
    end

    def new
        @song = Song.new
    end

    def create
        # byebug
        @song = Song.new(song_params)

        if @song.save
            redirect_to song_path(@song)
        else
            flash[:errors] = @song.errors.full_messages
            render :new
        end
    end

    def edit
        @song = Song.find(params[:id])
    end

    def update
        @song = Song.find(params[:id])
    end

    def destroy
        Song.delete(params[:id])

        redirect_to "/songs/new"
    end

    private

    def song_params
        params.require(:song).permit(:title, :release_year, :released, :genre, :artist_name)
    end
end
