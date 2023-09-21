class Genre
  attr_accessor :name, :id
  attr_reader :items

  @@all_genres = []

  def initialize(name)
    @name = name
    @id = rand(1..1000)
    @items = []
    @@all_genres << self
  end

  def add_item(item)
    @items << item
    item.genre = self
  end

  def self.list_genres
    @@all_genres
  end

  def self.find_by_id(id)
    @@all_genres.find { |genre| genre.id == id }
  end

  def self.find_or_create_by_name(name)
    existing_genre = @@all_genres.find { |genre| genre.name == name }
    existing_genre || Genre.new(name)
  end
end
