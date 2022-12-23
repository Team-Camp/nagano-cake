class Admin::OrderDetailsController < ApplicationController

  def update
    order = Order.find(params[:order_id])
    order_detail = OrderDetail.find(params[:id])

    if order_detail.update(order_detail_params)
      # フラッシュメッセージを設定
      flash[:notice] = "制作ステータスは更新されました"
      redirect_to admin_order_path(params[:order_id])
    else
      flash[:notice] = "制作ステータスの更新に失敗しました"
      redirect_to admin_order_path(params[:order_id])
    end
  end

  private
  # ストロングパラメータ
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end

end
