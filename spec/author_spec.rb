require_relative '../author'
require_relative '../game'

describe Author do
  describe '#add_item' do
    it 'adds an item to the author' do
      author = Author.new('Author Name')
      game = Game.new('Game Title', 'Genre', author, 'Label', Date.today, 'Platform', Date.today - 365)

      author.add_item(game)

      expect(author.items).to include(game)
      expect(game.author).to eq(author)
    end
  end
end
