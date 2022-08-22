require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:p1) { create(:product, price: 10) }
  let(:p2) { create(:product, price: 20) }
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

  it "聖誕節全面打 9 折。" do
    3.times { cart.add(p1.id) }
    5.times { cart.add(p2.id) }

    t = Time.local(Time.now.year, 12, 24, 10, 0, 0)
    Timecop.travel(t)
    
    expect(cart.total_price).to eq 117

    Timecop.return
  end

  it "滿千送百。" do
    p1 = create(:product, price: 100)
    p2 = create(:product, price: 200)

    3.times { cart.add(p1.id) }
    5.times { cart.add(p2.id) }
    
    expect(cart.total_price).to be 1200
  end

  it "將購物車內容轉換成 Hash 並存到 session 裡" do
    3.times { cart.add(p1.id)}
    2.times { cart.add(p2.id)}

    expect(cart.to_hash).to eq cart_hash
  end

  it "還原購物車內容" do
    cart = Cart.from_hash(cart_hash)

    expect(cart.items.first.product_id).to be 1
    expect(cart.items.last.quantity).to be 2
  end

  private
  def cart_hash
    result = {
      "items" => [
        {"product_id" => 1, "quantity" => 3},
        {"product_id" => 2, "quantity" => 2}
      ]
    }
  end
end
