require 'date'

class Item
  attr_reader :id, :genre, :author, :label, :publish_date
  attr_accessor :archived

  def initialize(genre, author, label, publish_date)
    @id = Random.rand(1..1000)
    @publish_date = publish_date
    @archived = archived
    @genre = genre
    @author = author
    @label = label
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
end
