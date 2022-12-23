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
      flash[:notice] = "注文ステータスの更新に失敗しました"
      redirect_to admin_order_path
    end
  end

  private
  # ストロングパラメータ
  def order_params
    params.require(:order).permit(:status)
  end

end
