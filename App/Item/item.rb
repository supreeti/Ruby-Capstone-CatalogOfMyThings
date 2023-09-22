require 'date'

class Item
  attr_reader :id, :genre, :label, :publish_date
  attr_accessor :archived, :author

  def initialize(genre, label, publish_date, author = nil, archived: false)
    @id = Random.rand(1..1000)
    @genre = genre
    @label = label
    @publish_date = publish_date
    @author = author
    @archived = archived
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
