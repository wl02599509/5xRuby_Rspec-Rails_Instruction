class Cart
  attr_accessor :items
  def initialize
    @items = []
  end
  
  def add(product_id, quantity = 1)
    found_item = @items.find { |item| item.product_id == product_id}

    if found_item
      found_item.increment(quantity)
    else
      @items << CartItem.new(product_id, quantity)
    end
  end

  def empty?
    @items.empty?
  end

  def total_price
    total = @items.reduce(0) { |acc, cv| acc + cv.total_price}
  end
end