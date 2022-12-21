class Admin::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])

    if @order.update(order_params)
      # フラッシュメッセージを設定
      flash[:notice] = "注文ステータスは更新されました"
      redirect_to admin_order_path
    else
      render :show
    end
  end

  private
  # ストロングパラメータ
  def oder_params
    params.require(:oder).permit(:status)
  end

end
