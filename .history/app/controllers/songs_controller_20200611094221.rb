class SongsController < ApplicationController
  def index
    @songs = Song.all
  end

  def show
    @song = set_song
  end

  def new
    @song = Song.new
  end

  def create
    artist = artist_f_or_c 
    genre = Genre.find_or_create_by(name: params[:song][:genre_id][:name])
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
    params.require(:song).permit(:title, :artist_id, :genre_id)
  end

  def set_song
    Song.find(params[:id])
  end

  def artist_f_or_c
    Artist.find_or_create_by(name: params[:song][:artist_id][:name])
  end

  def genre_params
    params.require(:genre_id).permit(:name)
  end

end

