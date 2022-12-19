class Admin::CustomersController < ApplicationController

#管理者(admin_user)のみ、編集と更新が可能
before_action :admin_user, only: [:edit, :update]

def index
 @admin_customers = Customer.all.page(params[:page])
end

#顧客詳細画面を表示
def show
 @admin_customer = Customer.find(params[:id])
end

#顧客編集画面を表示
def edit
 @admin_customer = Customer.find(params[:id])
end

#顧客編集画面で対象ユーザーを更新した時の処理内容
 def update
 @admin_customer = Customer.find(params[:id])
 @admin_customer.update
  if @admin_customer.save
   flash[:notice] = "You have updated successfully."
   redirect_to admin_customer_path
   flash[:notice] = "successfully"
  else
   flash[:alret] = "Error"
   render :'admin/customers/edit'
  end
 end
end