require_relative '../Item/item'

class Game < Item
  attr_accessor :author

  def initialize(title, genre, author, label, publish_date, platform, last_played_at)
    super(genre, author, label, publish_date)
    @title = title
    @genre = genre
    @author = author
    @label = label
    @platform = platform
    @last_played_at = last_played_at
    author.add_item(self)
  end

  def can_be_archived?
    super && @last_played_at < (Date.today - 730)
  end
end
