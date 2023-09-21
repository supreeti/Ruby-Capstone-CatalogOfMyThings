require_relative 'menu_options'
require_relative '../modules/book_label'

book_label = BookLabel.new

def main_menu(book_label)
  loop do
    display_menu
    print 'Please select an option (1-11 or 12 to quit): '
    choice = gets.chomp.to_i

    case choice
    when 1
      handle_listing_option(choice, book_label)
    when 8
      handle_adding_option(choice, book_label)
    when 12
      exit_app
      break
    else
      invalid_option_message
    end
  end
end

def handle_listing_option(choice, book_label)
  case choice
  when 1
    book_label.list_books
  end
end

def handle_listing_labels_or_authors(choice, book_label)
  case choice
  when 5
    book_label.list_labels
  end
end

def handle_adding_option(choice, book_label)
  case choice
  when 8
    book_label.add_book
  end
end

def exit_app
  puts 'Exiting the app. Goodbye!'
end

def invalid_option_message
  puts 'Invalid option. Please select a valid option (1-11 or 12 to quit).'
end

main_menu(book_label)
