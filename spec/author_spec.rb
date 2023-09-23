require 'rspec'
require_relative '../App/Item/item'
require_relative '../App/Author/author'

RSpec.describe Author do
  let(:author) { Author.new(1, 'John', 'Doe') }

  describe 'attributes' do
    it 'has an id' do
      expect(author.id).to eq(1)
    end

    it 'has a firstname' do
      expect(author.firstname).to eq('John')
    end

    it 'has a lastname' do
      expect(author.lastname).to eq('Doe')
    end

    it 'has an empty array of items' do
      expect(author.items).to be_an(Array)
      expect(author.items).to be_empty
    end
  end

  describe '#add_item' do
    it 'associates an item with the author' do
      item = double('Item')
      allow(item).to receive(:author=)
      author.add_item(item)
      expect(author.items).to include(item)
    end
  end
end
