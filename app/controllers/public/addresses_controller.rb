class Public::AddressesController < ApplicationController

  def index
    @addresses = Address.all
    @address = Address.new
  end

  def create
    @address = Address.new(address.params)

    if @address.save
      # フラッシュメッセージを定義
      flash[:notice] = "商品は新規登録されました"
      # showページにリダイレクト
      redirect_to public_addresses_path
    else
      render :index
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])

    if @address.update(address_params)
      # フラッシュメッセージを設定
      flash[:notice] = "商品は編集されました"
      redirect_to public_addresses_path
    else
      render :edit
    end
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy #任意のデータを削除
    redirect_to public_addresses_path #indexページへリダイレクト
  end

  private
  # ストロングパラメータ
  def address_params
    params.require(:address).permit(:customer_id,:postal_code,:address,:name)
  end

end
