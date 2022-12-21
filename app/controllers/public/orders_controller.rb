class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

 def new
   @order = Order.new
   @addresses = current_customer.addresses.all
 end

 def confirm
   @order = Order.new(order_params)
   if params[:order][:address_id] == "0"
    @order.postal_code = current_member.postal_code
    @order.address = current_member.address
    @order.name = current_member.last_name + current_member.first_name

   elsif params[:order][:address_id] == "1"
    @address = Address.find(params[:order][:address_id])
    @order.postal_code = @address.postal_code
    @order.address = @address.address
    @order.name = @address.name

   elsif params[:order][:address_id] = "2"
    @order.postal_code = params[:order][:postal_code]
    @order.address = params[:order][:address]
    @order.name = params[:order][:name]
   else
    render 'new'
   end

  @cart_items = current_customer.cart_items.all
  @order.customer_id = current_customer.id

 end

 def complete
 end

 def create
  @orders = Order.new(order_params)
  @order.customer_id = current_customer.id
  @order.save

  current_customer.cart_items.each do |cart_item|
  @order_details = OrderDetails.new
  @order_details.order_id = @order.id
  @order_details.item_id = cart_item.item_id
  @order_details.amount = cart_item.amount
  @order_details.price = (cart_item.item.price*1.08).floor
  @order_details.save
 end
  current_customer.cart_items.destroy_all
  redirect_to complete_public_orders_path
 end

 def index
   @orders = current_customer.orders
 end

 def show
   @order = Order.find(params[:id])
   @order_details = @order.order_details
 end

private
 def order_params
  params.require(:order).permit(:shipping_cost, :payment_method, :name, :address, :post_code, :customer_id, :total_payment, :status)
 end
end