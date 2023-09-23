require_relative '../Item/item'
require_relative '../Author/author'
require 'date'
require 'json'

class Game < Item
  attr_accessor :multiplayer, :last_played_at, :publish_date, :author
  attr_reader :id

  def initialize(id, author, genre, label, publish_date, multiplayer, last_played_at)
    super(genre, author, label, publish_date) # Use author's full name
    @id = id || Random.rand(1..100)
    @multiplayer = multiplayer
    @last_played_at = last_played_at
    @publish_date = publish_date
    @author = author # Set the author object directly
  end

  def can_be_archived?
    return (Date.today - Date.parse(last_played_at)).to_i > 730 if super

    false
  end

  def self.validate_date
    date_input = gets.chomp

    begin
      Date.parse(date_input)
    rescue ArgumentError
      puts 'Invalid date! Please enter a valid date.'
      validate_date
    end
  end

  def self.game_details
    game_data = {
      genre: 'Game',
      author: nil,
      label: nil,
      publish_date: Date.today,
      multiplayer: false,
      last_played_at: ''
    }

    print 'Enter the last played date (YYYY-MM-DD): '
    game_data[:last_played_at] = validate_date

    print 'Enter the author_firstname: '
    author_firstname = gets.chomp

    print 'Enter the author_lastname: '
    author_lastname = gets.chomp

    author = Author.new(author_firstname, author_lastname)
    game_data[:author] = author

    print 'Is the game multiplayer? (true/false): '
    game_data[:multiplayer] = gets.chomp.downcase == 'true'

    game_data
  end

  def self.add_a_game
    game_data = game_details
    loaded_games = load_games_data

    data = update_loaded_data(game_data, loaded_games)
    data[:game]
    author = data[:author]
    loaded_games = data[:loaded_games]
    loaded_authors = data[:loaded_authors]

    add_game_item_to_list(game_data, author)

    save_games_to_json(loaded_games)
    author.save_authors_to_file(loaded_authors)
  end

  def self.add_game_item_to_list(game_data, author)
    items = if File.exist?('items.json') && !File.empty?('items.json')
              JSON.parse(File.read('items.json'), symbolize_names: true)
            else
              []
            end

    # Create a new Game object and set its attributes
    item = Game.new(
      items.length + 1,
      author, # Set the author directly
      game_data[:genre],
      game_data[:label],
      game_data[:publish_date],
      game_data[:multiplayer],
      game_data[:last_played_at]
    )

    # Add the game to the author's list of items
    author.add_item(item)

    # Append the item to the items array
    items << item

    # Save the updated items array to JSON
    File.write('items.json', JSON.pretty_generate(items))

    puts 'Game added successfully!'
  end

  def self.update_loaded_data(game_data, loaded_games)
    loaded_authors = Author.load_authors_data

    author = Author.new(game_data[:author_firstname], game_data[:author_lastname])
    game = Game.new(
      loaded_games.length + 1,
      author, # Set the author directly
      game_data[:genre],
      game_data[:label],
      game_data[:publish_date],
      game_data[:multiplayer],
      game_data[:last_played_at]
    )

    loaded_authors << author
    loaded_games << game

    {
      game: game,
      author: author,
      loaded_authors: loaded_authors,
      loaded_games: loaded_games
    }
  end

  def self.save_games_to_json(games)
    data = games.map do |game|
      {
        'id' => game.id,
        'genre' => game.genre,
        'author' => game.author.full_name, # Assuming you want the author's full name
        'label' => game.label,
        'publish_date' => Date.today,
        'multiplayer' => game.multiplayer,
        'last_played_at' => game.last_played_at
      }
    end

    File.write('data/games.json', JSON.pretty_generate(data))
  end

  def self.load_games_data
    game_data = []

    if File.exist?('data/games.json') && !File.empty?('data/games.json')
      begin
        game_data = JSON.parse(File.read('data/games.json'))
      rescue JSON::ParserError => e
        puts "Error parsing 'data/games.json': #{e.message}"
      end
    else
      puts "File 'data/games.json' does not exist or is empty."
    end

    game_data.map do |data|
      publish_date = data['publish_date'] ? Date.parse(data['publish_date']) : Date.today
      author_name = data['author'] # Assuming author name is stored as a string
      author_firstname, author_lastname = author_name.split # Split the full name into first and last names
      author = Author.find_author_by_name(author_firstname, author_lastname) # Pass both names
      game = Game.new(
        data['id'],
        author, # Set the author directly
        data['genre'],
        data['label'],
        publish_date,
        data['multiplayer'],
        data['last_played_at']
      )
      game
    end
  end

  def self.list_all_games
    game_data = load_games_data
    game_data.each do |game|
      puts "ID: #{game.id}, Genre: #{game.genre}, Author: #{game.author.full_name}, " \
           "Label: #{game.label}, Published Date: #{game.publish_date}, " \
           "Multiplayer: #{game.multiplayer}, Last Played At: #{game.last_played_at}"
    end
  end
end
