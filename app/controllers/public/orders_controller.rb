class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

 def new
   @order = Order.new
   @addresses = current_customer.addresses.all
   if current_customer.cart_items.exists? == false
    redirect_to cart_items_path
   end
 end

 def confirm
   @order = Order.new(order_params)
   if params[:order][:select_address] == "0"
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.last_name + current_customer.first_name

   elsif params[:order][:select_address] == "1"
    @address = Address.find(params[:order][:address_id])
    @order.postal_code = @address.postal_code
    @order.address = @address.address
    @order.name = @address.name

   elsif params[:order][:select_address] =="2"
    @order.postal_code = params[:order][:postal_code]
    @order.address = params[:order][:address]
    @order.name = params[:order][:name]
   else
     render :new


   end

  @cart_items = current_customer.cart_items.all
  @order.customer_id = current_customer.id

 end

 def complete
 end

 def create

  @order = Order.new(order_params)

  @order.customer_id = current_customer.id
  @order.status = "wait_payment"
  if @order.save
  @cart_items = current_customer.cart_items.all
  @cart_items.each do |cart_item|
  @order_details = OrderDetail.new
  @order_details.order_id = @order.id
  @order_details.item_id = cart_item.item_id
  @order_details.amount = cart_item.amount
  @order_details.price = (cart_item.item.price*1.1).floor
  @order_details.save
  end
   current_customer.cart_items.destroy_all
   redirect_to complete_orders_path
  else
   render :new
  end



 end

 def index
   @orders = Order.all
 end

 def show
   @order = Order.find(params[:id])
   @order_details = @order.order_details
 end

private
 def order_params
  params.require(:order).permit(:shipping_cost, :payment_method, :name, :address, :postal_code, :customer_id, :total_payment, :status, :image)
 end
end