require_relative '../App/Author/author'

RSpec.describe Author do
  describe '#add_item' do
    it 'adds an item to the author' do
      author = Author.new('First Name', 'Last Name')
      game = Game.new('Game Title', 'Genre', author, 'Label', Date.today, 'Platform', Date.today - 730)
      author.add_item(game)
      expect(author.items).to include(game)
    end
  end
end
