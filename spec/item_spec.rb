require 'date'
require_relative '../App/Item/item'

RSpec.describe Item do
  describe '#initialize' do
    it 'creates a new item with the provided attributes' do
      item = Item.new('action', 'martin', 'Ray_publishing', Date.parse('21-09-2012'))
      expect(item.genre).to eq('action')
      expect(item.author).to eq('martin')
      expect(item.label).to eq('Ray_publishing')
      expect(item.publish_date).to eq(Date.parse('21-09-2012'))
      expect(item.archived).to be(false)
    end
  end

  describe '#can_be_archived?' do
    it 'returns true if the item is older than 10 years' do
      item = Item.new('action', 'martin', 'Ray_publishing', Date.parse('21-09-2012'))
      expect(item.can_be_archived?).to be(true)
    end

    it 'returns false if the item is not older than 10 years' do
      item = Item.new('action', 'martin', 'Ray_publishing', Date.parse('21-09-2019'))
      expect(item.can_be_archived?).to be(false)
    end
  end

  describe '#move_to_archive' do
    it 'archives item if it can be archived' do
      item = Item.new('action', 'martin', 'Ray_publishing', Date.parse('21-09-2012'))
      item.move_to_archive
      expect(item.archived).to be(true)
    end

    it 'does not archive the item if it cannot be archived' do
      item = Item.new('action', 'martin', 'Ray_publishing', Date.parse('21-09-2019'))
      expect { item.move_to_archive }.to output("Item cannot be archived...\n").to_stdout
      expect(item.archived).to be(false)
    end
  end
end
