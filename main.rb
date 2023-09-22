require 'json'
require_relative 'App/Game/game'
require_relative 'App/Author/author'
require_relative 'App/Item/item'
require_relative 'App/MusicAlbum/music_album'
require_relative 'App/Book/book_label'

# MusicAlbum.load_albums_from_json

book_label = BookLabel.new
ALBUMS_FILE = 'albums.json'.freeze
MOVIES_FILE = 'movies.json'.freeze
GAMES_FILE = 'games.json'.freeze
AUTHORS_FILE = 'authors.json'.freeze

# books = []
# albums = []
movies = []
games = []
authors = []

# books = JSON.parse(File.read(BOOKS_FILE)) if File.exist?(BOOKS_FILE)
# albums = JSON.parse(File.read(ALBUMS_FILE)) if File.exist?(ALBUMS_FILE)
movies = JSON.parse(File.read(MOVIES_FILE)) if File.exist?(MOVIES_FILE)
games = JSON.parse(File.read(GAMES_FILE)) if File.exist?(GAMES_FILE)

if File.exist?(AUTHORS_FILE)
  authors = JSON.parse(File.read(AUTHORS_FILE)).map do |author_data|
    Author.new(author_data['first_name'], author_data['last_name'])
  end
end

def list_games(games)
  games.each do |game|
    puts "Title: #{game.title}, Genre: #{game.genre}, Platform: #{game.platform}"
  end
end

def list_authors(authors)
  authors.each do |author|
    puts "Author: #{author.first_name} #{author.last_name}"
  end
end

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

# Save data to JSON files
File.write(GAMES_FILE, JSON.generate(games))
File.write(MOVIES_FILE, JSON.generate(movies))
File.write(AUTHORS_FILE, JSON.generate(authors))