require_relative '../Item/item'

class Game < Item
  attr_accessor :multiplayer, :last_played

  def initialize(_id, publish_date, multiplayer, last_played)
    super(nil, nil, nil, publish_date)
    @multiplayer = multiplayer
    @last_played = last_played || Time.now
  end

  def can_be_archived?
    super || @last_played > 2.year.ago
  end
end
