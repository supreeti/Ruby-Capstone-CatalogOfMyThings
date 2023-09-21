require 'date'

class Item
  attr_accessor :id, :genre, :author, :label, :publish_date, :archived

  def initialize(publish_date, archived: false)
    @id = Random.rand(1..1000)
    @publish_date = publish_date
    @archived = archived
    @genre = genre
    @author = author
    @label = label
  end

  def can_be_archived?
    current_date = Date.today
    year = current_date - @publish_date.year
    year >= 10
  end

  def move_to_archive
    if can_be_archived?
      @archived = true
    else
      puts 'Item cannot be archived...'
    end
  end
end
