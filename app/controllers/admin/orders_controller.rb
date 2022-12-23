class Admin::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])

    if @order.update(order_params)
      # フラッシュメッセージを設定
      flash[:notice] = "注文ステータスは更新されました"

      # 注文ステータスが「入金確認」になったら、紐づく制作ステータスをすべて「制作待ち」にする
      if @order.status == "confirm_payment"
        @order.order_details.each do |order_detail|
          if order_detail.making_status == "cannot_start"
            order_detail.update(making_status: "waiting_for_production")
          end
        end
      end

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
