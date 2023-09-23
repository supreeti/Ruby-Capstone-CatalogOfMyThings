require 'json'

class Author
  attr_accessor :id, :firstname, :lastname, :items

  def initialize(id, firstname, lastname)
    @id = id
    @firstname = firstname
    @lastname = lastname
    @items = []
  end

  def add_item(item)
    item.author = self
    @items << item
  end
end
