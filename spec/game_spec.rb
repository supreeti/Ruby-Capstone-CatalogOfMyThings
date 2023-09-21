require_relative '../game'

RSpec.describe Game do
  describe '#can_be_archived?' do
    it 'returns true when both conditions are met' do
      today = Date.today
      two_years_ago = today - 730
      author = Author.new('First Name', 'Last Name')
      game = Game.new('Game Title', 'Genre', author, 'Label', today, 'Platform', two_years_ago)
      expect(game.can_be_archived?).to be true
    end

    it 'returns false when last_played_at is not older than 2 years' do
      today = Date.today
      one_year_ago = today - 365
      author = Author.new('First Name', 'Last Name')
      game = Game.new('Game Title', 'Genre', author, 'Label', today, 'Platform', one_year_ago)
      expect(game.can_be_archived?).to be false
    end

    it 'returns false when the parent method returns false' do
      today = Date.today
      ten_years_ago = today - (10 * 365)
      author = Author.new('First Name', 'Last Name')
      game = Game.new('Game Title', 'Genre', author, 'Label', ten_years_ago, 'Platform', today)
      expect(game.can_be_archived?).to be false
    end
  end
end
