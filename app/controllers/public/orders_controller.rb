class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
 def new
   @order = Order.new
   @addresses = current_customer.addresses.all
 end
 
 def confirm
  @order = Order.new(order_params) 
  if params[:order][:address_option] == "0"
   @order.post_code = current_member.post_code
   @order.address = current_member.address
   @order.name = current_member.last_name + current_member.first_name 
  elsif params[:order][:address_option] == "1"
   ship = Address.find(params[:order][:customer_id])
   @order.post_code = ship.post_code
   @order.address = ship.address
   @order.name = ship.name 
  elsif params[:order][:address_option] = "2"
   @order.post_code = params[:order][:shipping_post_code]
   @order.address = params[:order][:shipping_address]
   @order.name = params[:order][:shipping_name]
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
  
  
  
 end
 
 def index
   
 end
 
 def show
 end
 
end
