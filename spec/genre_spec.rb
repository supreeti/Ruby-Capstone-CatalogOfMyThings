require 'rspec'
require_relative '../App/Genre/genre'

RSpec.describe Genre do
  before(:each) do
    Genre.class_variable_set(:@@all_genres, [])
  end

  describe '#add_item' do
    it 'adds an item to the genre\'s item list' do
      genre = Genre.new('Pop')
      item = double('Item')

      allow(item).to receive(:genre=)

      genre.add_item(item)

      expect(genre.items).to include(item)

      expect(item).to have_received(:genre=).with(genre)
    end
  end
end
