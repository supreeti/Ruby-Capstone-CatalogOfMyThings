require 'json'

class Author
  attr_accessor :id, :firstname, :lastname, :items

  def initialize(firstname, lastname)
    @firstname = firstname
    @lastname = lastname
    @items = []
  end

  def add_item(item)
    @items << item
  end

  def convert_to_hash
    {
      id: id,
      firstname: firstname,
      lastname: lastname
    }
  end

  def save_authors_to_file(authors)
    data = authors.map(&:convert_to_hash)
    File.write('authors.json', JSON.pretty_generate(data))
  end

  def self.load_authors_data
    return [] unless File.exist?('authors.json') && !File.empty?('authors.json')

    author_data = JSON.parse(File.read('authors.json'))
    author_data.map do |data|
      author = Author.new(data['firstname'], data['lastname'])
      author.id = data['id'] # Set the author's ID
      author
    end
  end

  def self.list_all_authors
    authors_data = load_authors_data
    authors_data.each do |author|
      puts "ID: #{author.id}, Name: #{author.firstname}, LastName: #{author.lastname} "
    end
  end
end
