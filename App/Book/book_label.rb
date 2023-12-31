require_relative 'book'
require_relative 'label'
require 'json'

class BookLabel
  BOOKS_FILE = 'data/book_label.json'.freeze

  attr_accessor :books, :labels

  def initialize
    @books = []
    @labels = []
    load_data
  end

  def list_books
    puts 'List of Books:'
    books.each do |book|
      puts "Id: #{book.id}, Publisher: #{book.publisher},  Cover State: #{book.cover_state}, " \
           "Publish Date: #{book.publish_date}"
    end
  end

  def list_labels
    puts 'List of Labels:'
    labels.each do |label|
      puts "Id: #{label.id}, Label Title: #{label.title}, Label Color: #{label.color}"
    end
  end

  def add_book
    puts 'Enter Title:'
    gets.chomp

    puts 'Enter the label title :'
    label_title = gets.chomp

    puts 'Enter the publish date of the book (DD-MM-YYYY):'
    publish_date = gets.chomp

    puts 'Enter the publisher of the book:'
    publisher = gets.chomp

    puts 'Enter the cover state of the book:'
    cover_state = gets.chomp

    puts 'Enter the genre book:'
    genre = gets.chomp

    puts 'Enter the author name:'
    author = gets.chomp

    label = find_or_create_label(label_title)
    book = Book.new(genre, author, label, publish_date, publisher, cover_state)
    books << book
    label.add_item(book)
    save_data
    puts 'Book added successfully!'
  end

  def save_data
    data = {
      books: books.map { |book| book_to_hash(book) },
      labels: labels.map { |label| label_to_hash(label) }
    }

    File.write(BOOKS_FILE, JSON.pretty_generate(data))
  end

  def load_data
    data = load_data_from_file(BOOKS_FILE)
    return unless data

    @books = data['books'].map { |hash| hash_to_book(hash) }
    @labels = data['labels'].map { |hash| hash_to_label(hash) }
  end

  private

  def book_to_hash(book)
    {
      id: book.id,
      genre: book.genre,
      author: book.author,
      publish_date: book.publish_date,
      publisher: book.publisher,
      cover_state: book.cover_state
    }
  end

  def label_to_hash(label)
    {
      id: label.id,
      title: label.title,
      color: label.color
    }
  end

  def find_or_create_label(title)
    label = labels.find { |l| l.title == title }
    if label.nil?
      label_id = books.length + 1

      if title && !title.empty?
        puts "Enter the color for the label '#{title}':"
        label_color = gets.chomp
      else
        label_color = 'Default Color'
      end

      label = Label.new(label_id, title, label_color)
      labels << label
    end
    label
  end

  def hash_to_book(hash)
    label = find_or_create_label(hash['label_title'])
    Book.new(
      hash['genre'],
      hash['author'],
      label,
      hash['publish_date'],
      hash['publisher'],
      hash['cover_state']
    )
  end

  def hash_to_label(hash)
    Label.new(hash['id'], hash['title'], hash['color'])
  end

  def load_data_from_file(file_path)
    return nil unless File.exist?(file_path)

    JSON.parse(File.read(file_path))
  rescue JSON::ParserError => _e
    nil
  end
end
