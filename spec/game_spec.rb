require 'date'
require_relative '../game'

describe Game do
  let(:today) { Date.today }
  let(:two_years_ago) { today - 730 }

  describe '#can_be_archived?' do
    it 'returns true when both conditions are met' do
      game = Game.new('Game Title', 'Genre', 'Author', 'Label', today, 'Platform', two_years_ago)
      expect(game.can_be_archived?).to eq(true)
    end

    it 'returns false when last_played_at is not older than 2 years' do
      game = Game.new('Game Title', 'Genre', 'Author', 'Label', today, 'Platform', today - 365)
      expect(game.can_be_archived?).to eq(false)
    end

    it 'returns false when the parent method returns false' do
      game = Game.new('Game Title', 'Genre', 'Author', 'Label', today - (10 * 365), 'Platform', two_years_ago)
      expect(game.can_be_archived?).to eq(false)
    end
  end
end
