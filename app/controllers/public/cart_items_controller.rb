class Public::CartItemsController < ApplicationController
 #before_action :setup_cart_item!, only: %i[add_item update_item delete_item]
  before_action :authenticate_customer!
#ショッピングカート内の商品表示
 def index
  @cart_items = current_customer.cart_items.includes(:item)
  @prices = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
  @amounts = current_customer.cart_items
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
  @cart_items = CartItem.find(params[:id])
  if @cart_items.destroy
   flash[:notice] = '対象商品が削除されました。'
  else
   flash[:alert] = '対象商品の削除に失敗しました。'
  end
  redirect_to public_cart_items_path
 end

 def destroy_all
  @cart_items = current_customer.cart_items
  if @cart_items.destroy_all
   flash[:notice] = 'カート内の全ての商品が削除されました。'
  else
   flash[:alert] = 'カート内の全ての商品の削除に失敗しました。'
  end
  redirect_to public_cart_items_path
 end

 def create
  if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
  cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
  cart_item.amount += params[:amount].to_i
  cart_item.update(amount: cart_item.amount)
  flash[:notice] = '商品が追加されました。'
  redirect_to public_cart_items_path
  else
   cart_item = current_customer.cart_items.new(cart_item_params)
   cart_item.save
   flash[:notice] = '商品の追加に成功しました。'
   redirect_to public_cart_items_path
  end
 end

   private
  def cart_item_params
   params.require(:cart_item).permit(:amount, :item_id)
  end

end