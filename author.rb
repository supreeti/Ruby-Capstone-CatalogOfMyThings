require_relative 'item'

class Author
  attr_reader :name
  attr_accessor :items

  def initialize(name)
    @name = name
    @items = []
  end

  def add_item(item)
    item.author = self
    items << item
  end
end
