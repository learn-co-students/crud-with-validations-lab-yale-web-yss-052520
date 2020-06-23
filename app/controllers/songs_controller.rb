require 'pry' 
class SongsController < ApplicationController

    def index
        @songs = Song.all
    end

    def show 
        @song = current_song 
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
            render :new 
        end 
    end 

    def edit 
        @song = current_song 
    end 

    def update 
        @song = current_song 
        @song.update(song_params) 
        if @song.valid? 
            @song.save 
            redirect_to song_path(@song)
        else 
            render :edit 
        end 
    end 

    def destroy  
        @song = current_song
        @song.destroy 
        redirect_to songs_path 
    end 

    def current_song 
        Song.find(params[:id]) 
    end 

    def song_params 
        params.require(:song).permit(:title, :genre, :artist_name, :released, :release_year)
    end 
end 