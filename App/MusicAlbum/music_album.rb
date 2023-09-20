class MusicAlbum
  attr_accessor :title, :artist, :release_date, :on_spotify, :genre_id, :archived
  attr_reader :id

  def initialize(title, artist, release_date, on_spotify, genre_id, archived)
    @title = title
    @artist = artist
    @release_date = release_date
    @on_spotify = on_spotify
    @genre_id = genre_id
    @archived = archived
    @id = nil # The ID will be assigned when inserted into the database
  end

  def can_be_archived?
    @archived && @on_spotify
  end
end
