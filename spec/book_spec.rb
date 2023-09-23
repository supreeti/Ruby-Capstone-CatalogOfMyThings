require_relative '../App/Book/book'
require 'date' # Add this line to require the 'date' library

describe Book do
  let(:book) { Book.new('action', 'martin', 'good', Date.parse('21-09-2023'), 'Mad Man', 'good') }

  context '#initialize' do
    it 'should create a new book' do
      expect(book).to be_a(Book)
    end
  end

  context '#can_be_archived?' do
    it 'when cover state is not "bad" returns true if the parent method returns true' do
      expect(book.can_be_archived?).to be false
    end

    it 'when the cover state is "bad" returns true' do
      book.cover_state = 'bad'
      expect(book.can_be_archived?).to be true
    end
  end
end
