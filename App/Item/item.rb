require 'date'

class Item
  attr_reader :id, :genre, :label, :publish_date
  attr_accessor :archived, :author

  def initialize(genre, author, label, publish_date, archived: false)
    @id = Random.rand(1..1000)
    @genre = genre
    @label = label
    @publish_date = publish_date
    @author = author
    @archived = archived
    album.add_item(self)
  end

  def can_be_archived?
    publish_date < (Date.today - (10 * 365))
  end

  def move_to_archive
    if can_be_archived?
      @archived = true
    else
      puts 'Item cannot be archived...'
    end
  end

  def genre=(genre)
    @genre = genre
    genre.items.push(self) unless genre.items.include?(self)
  end

  def label=(label)
    @label = label
    label.items.push(self) unless label.items.include?(self)
  end

  def autor=(author)
    @author = author
    author.items.push(self) unless author.items.include?(self)
  end
end
