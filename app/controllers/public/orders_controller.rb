class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
 def new
   @order = Order.new
   @addresses = current_customer.addresses.all
 end
 
 def confirm
  @order = Order.new(order_params) 
 end
 
 def complete
 end
 
 def create
  @orders = Order.new(order_params)
  
 end
 
 def index
 end
 
 def show
 end
 
end
