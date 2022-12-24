class Admin::OrderDetailsController < ApplicationController

  def update
    order = Order.find(params[:order_id])
    order_detail = OrderDetail.find(params[:id])

    if order_detail.update(order_detail_params)
      # フラッシュメッセージを設定
      flash[:notice] = "制作ステータスは更新されました"

      # 制作ステータスが一つでも「製作中」になったときに、注文ステータスが「入金待ち」もしくは「入金確認」の場合、「製作中」となる
      if order_detail.making_status == "in_production" && (order.status == "wait_payment" || order.status == "confirm_payment")
        order.update(status:"making")
      end

      # 制作ステータスがすべて「制作終了」となったとき、注文ステータスを「発送準備中」に変更
      order_details_amount = 0
      finished_amount = 0
      order.order_details.each do |f|
        if f.making_status == "finished"
          finished_amount += 1
        end
        order_details_amount += 1
      end
      if order_details_amount == finished_amount
        order.update(status:"preparing_ship")
      end

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
