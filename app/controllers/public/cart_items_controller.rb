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
  if @cart_item.destroy
   flash[:notice] = 'アイテムが削除されました。'
  else
   flash[:alert] = '削除に失敗しました。'
  end

 def destroy_all
  if @cart_item.destroy_all
   flash[:notice] = 'カート内のアイテムが全て削除されました。'
  else
   flash[:alert] = 'カート内のアイテムの削除に失敗しました。'
  end
 end

 def create
  @cart_item ||= current_cart.cart_cart_items.build(product_id: params[:product_id])
  @cart_item.amount += params[:quantity].to_i
  if @cart_item.save
   flash[:notice] = '商品が追加されました。'
   redirect_to root_path
  else
   flash[:alert] = '商品の追加に失敗しました。'
　 redirect_to root_path
　end
  end