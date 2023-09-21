class Author
  attr_reader :items

  def initialize(first_name, last_name)
    @id = generate_unique_id
    @first_name = first_name
    @last_name = last_name
    @items = []
  end

  def add_item(item)
    @items << item
    item.author = self
  end

  private

  def generate_unique_id
    timestamp = Time.now.to_i * 1000
    random_number = rand(10_000)
    "Aut#{timestamp}#{random_number}"
  end
end
