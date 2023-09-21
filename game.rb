# game.rb
class Game < Item
  attr_accessor :author # Add this line

  def initialize(multilayer, last_played_at, archived, publish_date, author)
    super(archived, publish_date)
    @multilayer = multilayer
    @last_played_at = last_played_at
    author.add_item(self)
  end

  private

  def can_be_archived?
    super && (Time.new.year - @last_played_at.year) > 2
  end
end
