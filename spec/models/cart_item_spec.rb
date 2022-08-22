require 'rails_helper'

RSpec.describe CartItem, type: :model do
  let(:p1) { create(:product, price: 10) }
  let(:p2) { create(:product, price: 20) }
  let(:cart) { Cart.new }
  
  it "每個 Cart Item 都可以計算它自己的金額（小計）。" do
    3.times { cart.add(p1.id) }
    5.times { cart.add(p2.id) }
    
    expect(cart.total_price).to eq 130
  end
end