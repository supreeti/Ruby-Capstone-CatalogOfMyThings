require_relative '../Item/item'
require_relative '../Author/author'
require_relative 'game'
require 'date'
require 'json'

class GameAuthor
  BOOKS_FILE = 'data/game_author.json'.freeze

  def initialize
    @games = []
    @authors = []
    load_data
  end

  def add_game
    id = @games.empty? ? 1 : @games.last.id + 1

    puts "Enter Author's First Name:"
    firstname = gets.chomp

    puts "Enter Author's Last Name:"
    lastname = gets.chomp

    author = find_or_create_author(id, firstname, lastname)

    puts 'Enter Publish Date (DD-MM-YYYY):'
    publish_date = gets.chomp

    puts 'Is it Multiplayer? (true/false):'
    multiplayer = gets.chomp.downcase == 'true'

    puts 'Enter Last Played (DD-MM-YYYY) (or press Enter for the current date):'
    last_played = gets.chomp
    last_played = Time.now.strftime('%d-%m-%Y') if last_played.empty?

    game = Game.new(id, publish_date, multiplayer, last_played)
    author.add_item(game)
    @games << game
    save_data
    puts 'Game added successfully!'
  end

  def list_games
    puts 'List of Games:'
    @games.each do |game|
      puts "ID: #{game.id}, Publish Date: #{game.publish_date}, Multiplayer: #{game.multiplayer}, " \
           "Last Played: #{game.last_played}"
    end
  end

  def list_authors
    puts 'List of Authors:'
    @authors.each do |author|
      puts "ID: #{author.id}, First Name: #{author.firstname}, Last Name: #{author.lastname}"
    end
  end

  private

  def save_data
    game_data = prepare_game_data
    author_data = prepare_author_data
    data = {
      games: game_data,
      authors: author_data
    }
    save_to_file(data, BOOKS_FILE)
  end

  def prepare_game_data
    @games.map do |game|
      {
        id: game.id,
        publish_date: game.publish_date,
        multiplayer: game.multiplayer,
        last_played: game.last_played
      }
    end
  end

  def prepare_author_data
    @authors.map do |author|
      {
        id: author.id,
        firstname: author.firstname,
        lastname: author.lastname
      }
    end
  end

  def prepare_author_items(author)
    author.items.map do |item|
      {
        id: item.id,
        publish_date: item.publish_date,
        multiplayer: item.multiplayer,
        last_played: item.last_played
      }
    end
  end

  def save_to_file(data, file_path)
    File.write(file_path, JSON.pretty_generate(data))
  end

  def load_data
    data = load_data_from_file(BOOKS_FILE)
    return initialize_data unless data

    unless data.is_a?(Hash) && data.key?('games') && data.key?('authors')
      puts 'Error: Invalid data structure in game_author.json.'
      return initialize_data
    end

    @games = data['games'].map { |game_data| Game.new(*game_data.values) }
    @authors = data['authors'].map do |author_data|
      Author.new(
        author_data['id'],
        author_data['firstname'],
        author_data['lastname']
      )
    end
  end

  def load_data_from_file(file_path)
    return nil unless File.exist?(file_path)

    JSON.parse(File.read(file_path))
  rescue JSON::ParserError => _e
    nil
  end

  def initialize_data
    @games = []
    @authors = []
  end

  def find_or_create_author(id, firstname, lastname)
    author = @authors.find { |a| a.id == id }
    return author if author

    new_author = Author.new(id, firstname, lastname)
    @authors << new_author
    new_author
  end
end
