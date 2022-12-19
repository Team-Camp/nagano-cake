class Admin::CustomersController < ApplicationController

#管理者(admin_user)のみ、編集と更新が可能
before_action :admin_user, only: [:edit, :update]

def index
 @admin_customers = Customer.all.page(params[:page])
end

def show
 @admin_customer = Customer.find(params[:id])
end

def edit
end

def update
end
end
