class SongsController < ApplicationController
  def index
    @songs = Song.all
  end

  def show
    @song = set_song
  end

  def new
    @song = Song.new
    @song.notes.build
  end

  def create
    @song = Song.new(song_params)
    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = set_song
  end

  def update
    @song = set_song

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = set_song
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name, :genre_id, notes_attributes: [])
  end

  def set_song
    Song.find(params[:id])
  end



end

