require 'json'
require_relative 'game'
require_relative 'author'
require_relative 'item'

BOOKS_FILE = 'books.json'.freeze
ALBUMS_FILE = 'albums.json'.freeze
MOVIES_FILE = 'movies.json'.freeze
GAMES_FILE = 'games.json'.freeze
AUTHORS_FILE = 'authors.json'.freeze

books = []
albums = []
movies = []
games = []
authors = []

books = JSON.parse(File.read(BOOKS_FILE)) if File.exist?(BOOKS_FILE)
albums = JSON.parse(File.read(ALBUMS_FILE)) if File.exist?(ALBUMS_FILE)
movies = JSON.parse(File.read(MOVIES_FILE)) if File.exist?(MOVIES_FILE)
games = JSON.parse(File.read(GAMES_FILE)) if File.exist?(GAMES_FILE)

if File.exist?(AUTHORS_FILE)
  authors = JSON.parse(File.read(AUTHORS_FILE)).map do |author_data|
    Author.new(author_data['first_name'], author_data['last_name'])
  end
end

# def list_albums

# end

# def list_movies

# end

def list_games(games)
  games.each do |game|
    puts "Title: #{game.title}, Genre: #{game.genre}, Platform: #{game.platform}"
  end
end

# def list_genres

# end

# def list_labels

# end

def list_authors(authors)
  authors.each do |author|
    puts "Author: #{author.first_name} #{author.last_name}"
  end
end

# def list_sources

# end

# def add_book

# end

# def add_album

# end

# def add_movie

# end

def add_game(games, authors)
  print 'Enter Game Title: '
  title = gets.chomp
  print 'Enter Genre: '
  genre = gets.chomp
  print 'Enter Author First Name: '
  first_name = gets.chomp
  print 'Enter Author Last Name: '
  last_name = gets.chomp
  print 'Enter Label: '
  label = gets.chomp
  print 'Enter Publish Date (YYYY-MM-DD): '
  publish_date = Date.parse(gets.chomp)
  print 'Enter Platform: '
  platform = gets.chomp
  print 'Enter Last Played Date (YYYY-MM-DD): '
  last_played_at = Date.parse(gets.chomp)

  author = authors.find do |a|
    a.first_name == first_name && a.last_name == last_name
  end || Author.new(first_name, last_name)
  game = Game.new(title, genre, author, label, publish_date, platform, last_played_at)

  author.add_item(game)
  games << game

  puts 'Game added successfully!'
end

loop do
  puts "\nOptions:"
  puts '1. List all books'
  puts '2. List all music albums'
  puts '3. List all movies'
  puts '4. List all games'
  puts '5. List all genres'
  puts '6. List all labels'
  puts '7. List all authors'
  puts '8. List all sources'
  puts '9. Add a book'
  puts '10. Add a music album'
  puts '11. Add a movie'
  puts '12. Add a game'
  puts '13. Quit'

  print 'Choose an option: '
  choice = gets.chomp.to_i

  case choice
  when 1
    # Implement list_books(books)
  when 2
    list_games(games)
  when 3
    # Implement list_movies(movies)
  when 4
    # Implement list_albums(albums)
  when 5
    # Implement list_genres
  when 6
    # Implement list_labels
  when 7
    list_authors(authors)
  when 8
    # Implement list_sources
  when 9
    # Implement add_book(books)
  when 10
    add_game(games, authors)
  when 11
    # Implement add_movie(movies)
  when 12
    # Implement add_album(albums)
  when 13
    puts 'Goodbye!'
    break
  else
    puts 'Invalid choice. Please select a valid option.'
  end
end

# Save data to JSON files
File.write(BOOKS_FILE, JSON.generate(books))
File.write(GAMES_FILE, JSON.generate(games))
File.write(ALBUMS_FILE, JSON.generate(albums))
File.write(MOVIES_FILE, JSON.generate(movies))
File.write(AUTHORS_FILE, JSON.generate(authors))
