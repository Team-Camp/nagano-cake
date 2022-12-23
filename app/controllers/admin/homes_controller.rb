class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  
  def top
    @admin_customers = Customer.all.page(params[:page])
  end
    
  
end
