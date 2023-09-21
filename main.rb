require 'json'

BOOKS_FILE = 'books.json'.freeze
ALBUMS_FILE = 'albums.json'.freeze
MOVIES_FILE = 'movies.json'.freeze
GAMES_FILE = 'games.json'.freeze

# def list_albums

# end

# def list_movies

# end

# def list_games

# end

# def list_genres

# end

# def list_labels

# end

# def list_authors

# end

# def list_sources

# end

# def add_book

# end

# def add_album

# end

# def add_movie

# end

# def add_game

# end

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
    list_books
  when 2
    list_albums
  when 3
    list_movies
  when 4
    list_games
  when 5
    list_genres
  when 6
    list_labels
  when 7
    list_authors
  when 8
    list_sources
  when 9
    add_book
  when 10
    add_album
  when 11
    add_movie
  when 12
    add_game
  when 13
    puts 'Goodbye!'
    break
  else
    puts 'Invalid choice. Please select a valid option.'
  end
end
