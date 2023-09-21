require 'date'
require_relative 'item'

class Game < Item
  attr_reader :title, :platform, :last_played_at

  def initialize(title, genre, author, label, publish_date, platform, last_played_at)
    super(genre, author, label, publish_date)
    @title = title
    @platform = platform
    @last_played_at = last_played_at
  end

  def can_be_archived?
    super && last_played_at < (Date.today - 730) # 2 years = 730 days
  end
end
