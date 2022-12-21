class Public::CartItemsController < ApplicationController
 before_action :setup_cart_item!, only: %i[add_item update_item delete_item]

#ショッピングカート内の商品表示
 def index
  @cart_items = current_cart.cart_items.includes([:product])
  @prices = Price.find
  @amounts = current_cart.cart_items.includes([:amount])
 end

 def show
 end

 def edit
 end

 def update
 end

end
