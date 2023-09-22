require 'json'
require_relative 'App/Game/game'
require_relative 'App/Author/author'
require_relative 'App/Item/item'
require_relative 'App/MusicAlbum/music_album'
require_relative 'App/Book/book_label'

MusicAlbum.load_albums_from_json

book_label = BookLabel.new
ALBUMS_FILE = 'albums.json'.freeze
MOVIES_FILE = 'movies.json'.freeze
GAMES_FILE = 'games.json'.freeze
AUTHORS_FILE = 'authors.json'.freeze


loop do
  puts "\nOptions:"
  puts '1. List all books'
  puts '2. List all music albums'
  puts '3. List all movies'
  puts '4. List all games'
  puts '5. List all genres'
  puts '6. List all labels'
  puts '7. List all authors'
  puts '8. Add a book'
  puts '9. Add a music album'
  puts '10. Add a movie'
  puts '11. Add a game'
  puts '12. Quit'

  print 'Choose an option: '
  choice = gets.chomp.to_i

  case choice
  when 1
    book_label.list_books
  when 2
    MusicAlbum.list_albums
  when 3
    # Implement list_movies(movies)
  when 4
    list_games(games)
  when 5
    MusicAlbum.list_genres
  when 6
    book_label.list_labels
  when 7
    list_authors(authors)
  when 8
    book_label.add_book
  when 9
    add_album
    MusicAlbum.save_albums_to_json
  when 10
    # Implement add_movie(movies)
  when 11
    add_game(games, authors)
  when 12
    puts 'Goodbye!'
    break
  else
    puts 'Invalid choice. Please select a valid option.'
  end
end
