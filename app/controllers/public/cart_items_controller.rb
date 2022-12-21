class Public::CartItemsController < ApplicationController
 #before_action :setup_cart_item!, only: %i[add_item update_item delete_item]
  before_action :authenticate_customer!
#ショッピングカート内の商品表示
 def index
  @cart_items = current_customer.cart_items.includes([:item])
  @prices = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
  @amounts = current_customer.cart_items.includes([:amount])
 end

#カート内アイテムの更新
 def update
  if @cart_items.update(amount: params[:amount].to_i)
   flash[:notice] = 'カート内商品の更新に成功しました。'
  else
   flash[:alert] = 'カート内商品の更新に失敗しました'
  end
  redirect_to public_cart_items_path
 end

#カート内アイテムの一部削除
 def destroy
  if @cart_items.destroy
   flash[:notice] = '対象商品が削除されました。'
  else
   flash[:alert] = '対象商品の削除に失敗しました。'
  end
  redirect_to public_cart_items_path
 end

 def destroy_all
  if @cart_items.destroy_all
   flash[:notice] = 'カート内の全ての商品が削除されました。'
  else
   flash[:alert] = 'カート内の全ての商品の削除に失敗しました。'
  end
  redirect_to public_cart_items_path
 end

 def create
  @cart_items ||= current_cart.cart_cart_items.build(product_id: params[:product_id])
  @cart_items.amount += params[:quantity].to_i
  if @cart_items.save
   flash[:notice] = '商品が追加されました。'
   redirect_to public_cart_items_path
  else
   flash[:alert] = '商品の追加に失敗しました。'
　 redirect_to public_cart_items_path
　 end
 end
end