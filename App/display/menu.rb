require_relative 'menu_options'
require_relative '../modules/book_label'

book_label = BookLabel.new

def main_menu(book_label)
  loop do
    display_menu
    print 'Please select an option (1-11 or 12 to quit): '
    choice = gets.chomp.to_i

    case choice
    when 1..4
      handle_listing_option(choice, media_library, game_author, book_label)
    when 5..7
      handle_listing_labels_or_authors(choice, media_library, game_author, book_label)
    when 8..11
      handle_adding_option(choice, media_library, game_author, book_label)
    when 12
      exit_app
      break
    else
      invalid_option_message
    end
  end
end

def handle_listing_option(choice, media_library, game_author, book_label)
  case choice
  when 1
    book_label.list_books
  when 2
    media_library.list_music_albums
  when 3
    game_author.list_games
  when 4
    media_library.list_genres
  end
end

def handle_listing_labels_or_authors(choice, _media_library, game_author, book_label)
  case choice
  when 5
    book_label.list_labels
  when 6
    game_author.list_authors
  end
end

def handle_adding_option(choice, media_library, game_author, book_label)
  case choice
  when 8
    book_label.add_book
  when 9
    media_library.add_music_album
  when 10
    movie.add_game
  when 11
    game_author.add_game
  end
end

def exit_app
  puts 'Exiting the app. Goodbye!'
end

def invalid_option_message
  puts 'Invalid option. Please select a valid option (1-9 or 0 to quit).'
end

main_menu(media_library, game_author, book_label)
