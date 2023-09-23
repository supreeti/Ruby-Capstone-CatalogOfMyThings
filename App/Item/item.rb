class Item
  attr_reader :id, :genre, :author, :label, :publish_date
  attr_accessor :archived

  def initialize(genre, author, label, publish_date)
    @id = Random.rand(1..1000)
    @genre = genre
    @author = author
    @label = label
    @publish_date = publish_date
    @archived = false
  end

  def can_be_archived?
    # Calculate the date 10 years ago from today
    ten_years_ago = Date.today - (10 * 365)

    # Compare the publish_date with ten_years_ago
    publish_date < ten_years_ago
  end

  def move_to_archive
    if can_be_archived?
      @archived = true
      puts 'Item has been archived.'
    else
      puts 'Item cannot be archived.'
    end
  end

  def genre=(genre)
    @genre = genre
    genre.items.push(self) unless genre.items.include?(self)
  end

  def label=(label)
    @label = label
    label.items.push(self) unless label.items.include?(self)
  end

  def author=(author)
    @author = author
    author.items.push(self) unless author.items.include?(self)
  end
end
