require_relative '../App/Item/item'
require_relative '../App/Genre/genre'
require_relative '../App/Book/label'
require_relative '../App/Author/author'
require 'date'

# Define mock classes for associations
class Genre
  attr_accessor :items
  def initialize
    @items = []
  end
end

class Label
  attr_accessor :items
  def initialize
    @items = []
  end
end

class Author
  attr_accessor :items
  def initialize
    @items = []
  end
end

describe Item do
  let(:item) { Item.new }

  it 'has a unique ID' do
    expect(item.id).to be_between(1, 1000).inclusive
  end

  it 'is not archived by default' do
    expect(item.archived).to be false
  end

  describe '#can_be_archived?' do
    it 'returns true if the publish date is more than 10 years ago' do
      item.instance_variable_set(:@publish_date, Date.today - (11 * 365))
      expect(item.can_be_archived?).to be true
    end

    it 'returns false if the publish date is less than 10 years ago' do
      item.instance_variable_set(:@publish_date, Date.today - (9 * 365))
      expect(item.can_be_archived?).to be false
    end
  end

  describe '#move_to_archive' do
    it 'archives the item if it can be archived' do
      item.instance_variable_set(:@publish_date, Date.today - (11 * 365))
      expect { item.move_to_archive }.to change { item.archived }.from(false).to(true)
    end

    it 'does not archive the item if it cannot be archived' do
      item.instance_variable_set(:@publish_date, Date.today - (9 * 365))
      expect { item.move_to_archive }.not_to change { item.archived }
    end
  end

  describe 'associations' do
    let(:genre) { Genre.new }
    let(:label) { Label.new }
    let(:author) { Author.new }

    it 'adds itself to genre items' do
      item.genre = genre
      expect(genre.items).to include(item)
    end

    it 'adds itself to label items' do
      item.label = label
      expect(label.items).to include(item)
    end

    it 'adds itself to author items' do
      item.author = author
      expect(author.items).to include(item)
    end
  end
end
