require 'json'
require_relative '../Genre/genre'

class MusicAlbum
  attr_accessor :title, :artist, :release_date, :on_spotify, :genre_id, :archived
  attr_reader :id

  @@all_albums = []

  def initialize(title, artist, release_date, on_spotify, genre_name)
    @title = title
    @artist = artist
    @release_date = release_date
    @on_spotify = on_spotify
    @genre_id = Genre.find_or_create_by_name(genre_name).id
    @archived = can_be_archived?
    @id = generate_id
    MusicAlbum.load_data_if_needed
  end

  def self.load_data_if_needed
    return if @loaded_data
    load_albums_from_json
    @loaded_data = true
  end

  def generate_id
    Random.rand(1...1000)
  end

  def can_be_archived?
    @archived && @on_spotify
  end

  def self.list_albums
    @@all_albums.each do |album|
      genre = Genre.find_by_id(album.genre_id)
      puts "Title: #{album.title}, Artist: #{album.artist}, Genre: #{genre ? genre.name : 'Unknown'}"
    end
  end

  def self.load_albums_from_json
    if File.exist?('albums.json')
      file_data = File.read('albums.json')
      album_data = JSON.parse(file_data)
      temp_albums = []

      album_data.each do |data|
        album = MusicAlbum.new(data['title'], data['artist'], data['release_date'], data['on_spotify'], data['genre_name'])
        album.instance_variable_set(:@id, data['id'])
        temp_albums << album
      end

      @@all_albums = temp_albums  # Reemplazar la lista de álbumes existente
    end
  rescue JSON::ParserError, StandardError => e
    puts "Error al cargar datos desde el archivo JSON: #{e.message}"
  end

  def self.save_albums_to_json
    albums_json = @@all_albums.map do |album|
      {
        id: album.id,
        title: album.title,
        artist: album.artist,
        release_date: album.release_date,
        on_spotify: album.on_spotify,
        genre_id: album.genre_id,
        genre_name: Genre.find_by_id(album.genre_id)&.name,
        archived: album.archived
      }
    end

    json_file_path = File.join(File.dirname(__FILE__), '..', '..', 'data', 'albums.json')

    File.open(json_file_path, 'w') do |file|
      file.puts JSON.pretty_generate(albums_json)
    end
  rescue JSON::GeneratorError, StandardError => e
    puts "Error al guardar datos en el archivo JSON: #{e.message}"
  end

  def self.add_album
    load_albums_from_json

    print 'Enter the title of the album: '
    title = gets.chomp

    print 'Enter the artist of the album: '
    artist = gets.chomp

    print 'Enter the release date of the album: '
    release_date = gets.chomp

    print 'Is the album on Spotify? (true/false): '
    on_spotify = gets.chomp.downcase == 'true'

    print 'Enter the genre of the album: '
    genre_name = gets.chomp

    album = MusicAlbum.new(title, artist, release_date, on_spotify, genre_name)
    @@all_albums << album
    save_albums_to_json
  end
end

def add_album
  MusicAlbum.add_album
end




