class CartItem
  attr_accessor :product_id, :quantity

  def initialize(product_id, quantity = 1)
    @product_id = product_id
    @quantity = quantity
  end

  def increment(quantity = 1)
    @quantity += quantity
  end

  def product
    Product.find(@product_id)
  end

  def total_price
    @quantity * product.price
  end
end