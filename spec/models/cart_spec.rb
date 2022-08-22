require 'rails_helper'


RSpec.describe Cart, type: :model do
  let(:p1) { Product.create(title: "P1", price: 10) }
  let(:cart) { Cart.new }

  it "可以把商品丟到到購物車裡，然後購物車裡就有東西了。" do
    # A = Arrange
    cart = Cart.new

    # A = Act
    cart.add(p1)

    # A = Assert
    expect(cart.empty?).not_to be(nil)
  end

  it "如果加了相同種類的商品到購物車裡，購買項目（CartItem）並不會增加，但商品的數量會改變。" do
    cart = Cart.new

    3.times { cart.add(2) }
    2.times { cart.add(5) }
    3.times { cart.add(2) }

    expect(cart.items.count).to be 2
    # expect(cart.items.first.quantity).to be 6
  end

  it "商品可以放到購物車裡，也可以再拿出來。" do
    p1 = FactoryBot.create(:product, price: 10)

    cart.add(p1.id)

    expect(cart.items.first.product).to be_a Product
    expect(cart.items.first.product.price).to be 10

  end

  it "每個 Cart Item 都可以計算它自己的金額（小計）。" do
    p1 = create(:product, price: 10)
    p2 = create(:product, price: 20)

    3.times { cart.add(p1.id)}
    5.times { cart.add(p2.id)}
    
    expect( cart.total_price).to be 130

  end
end
