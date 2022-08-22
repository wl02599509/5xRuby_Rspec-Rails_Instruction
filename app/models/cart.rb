class Cart
  attr_accessor :items

  def initialize(item = [])
    @items = item
  end

  def self.from_hash(hash)
    items = []
    if hash && hash["items"]
      items = hash["items"].map { |item|
        CartItem.new(item["product_id"], item["quantity"])
      }
    end

    new(items)
    #Cart.new(items)
  end

  def to_hash
    {
      "items" => @items.map { |item|
        {
          "product_id" => item.product_id, 
          "quantity" => item.quantity 
        }
      }
    }
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
    
    if is_xmas?
      total = total * 0.9
    end

    if total > 1000
      total = total - 100
    end

    total
  end

  private
  def is_xmas?
    Time.now.month == 12 && [24, 25].include?(Time.now.day)
  end
end