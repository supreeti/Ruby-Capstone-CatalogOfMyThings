class Genre
  attr_accessor :name, :id
  attr_reader :items

  def initialize(name)
    @name = name
    @id = nil # The ID will be assigned when inserted into the database
    @items = []
  end

  def add_item(item)
    @items << item
    item.genre = self
  end
end
