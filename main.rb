require 'json'
require_relative 'App/Game/game'
require_relative 'App/Author/author'
require_relative 'App/Item/item'
require_relative 'App/MusicAlbum/music_album'
require_relative 'App/Book/book_label'

MusicAlbum.load_albums_from_json

book_label = BookLabel.new

loop do
  puts "\nOptions:"
  puts '1. List all books'
  puts '2. List all music albums'
  puts '3. List all games'
  puts '4. List all genres'
  puts '5. List all labels'
  puts '6. List all authors'
  puts '7. Add a book'
  puts '8. Add a music album'
  puts '9. Add a game'
  puts '10. Quit'

  print 'Choose an option: '
  choice = gets.chomp.to_i

  case choice
  when 1
    book_label.list_books
  when 2
    MusicAlbum.list_albums
  when 3
    Game.list_all_games
  when 4
    MusicAlbum.list_genres
  when 5
    book_label.list_labels
  when 6
    Author.list_all_authors
  when 7
    book_label.add_book
  when 8
    add_album
    MusicAlbum.save_albums_to_json
  when 9
    Game.add_a_game
  when 10
    puts 'Goodbye!'
    break
  else
    puts 'Invalid choice. Please select a valid option.'
  end
end
