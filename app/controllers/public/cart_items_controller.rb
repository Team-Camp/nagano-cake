class Public::CartItemsController < ApplicationController
 before_action :setup_cart_item!, only: %i[add_item update_item delete_item]

#ショッピングカート内の商品表示
 def index
  @cart_items = current_cart.cart_items.includes([:item])
  @prices = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
  @amounts = current_cart.cart_items.includes([:amount])
 end

 def update
 end

 def destroy
 end

 def destroy_all
 end

 def create
 end

end
