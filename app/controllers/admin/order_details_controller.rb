class Admin::OrderDetailsController < ApplicationController

  def update
    @order_detail = Order_detail.find(params[:id])

    if @order_detail.update(order_detail_params)
      # フラッシュメッセージを設定
      flash[:notice] = "制作ステータスは更新されました"
      redirect_to admin_order_path
    else
      render :show
    end
  end

  private
  # ストロングパラメータ
  def oder_detail_params
    params.require(:oder_detail).permit(:making_status)
  end

end
