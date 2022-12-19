class Admin::ItemsController < ApplicationController

  def new
    @item = Item.new
  end

  def index
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      # フラッシュメッセージを定義
      flash[:notice] = "商品は新規登録されました"
      # showページにリダイレクト
      redirect_to admin_item_path(@item.id)
    else
      # indexページにリダイレクト（ページを移動せずそのまま更新）
      # render :indexするとindexアクションをすっ飛ばすため、ここにBook.allのインスタンスを作る必要あり
      @item = Item.all
      # redirect_to books_path
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  private
  # ストロングパラメータ
  def item_params
    params.require(:item).permit(:name,:introduction,:price,:is_active,:image)
  end

end
