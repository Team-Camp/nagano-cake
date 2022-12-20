class Admin::ItemsController < ApplicationController

  def new
    @item = Item.new
  end

  def index
    # ページネーションを適用
    @items = Item.page(params[:page])
  end

  def create
    @item = Item.new(item_params)
    @genre = Genre.all

    if @item.save
      # フラッシュメッセージを定義
      flash[:notice] = "商品は新規登録されました"
      # showページにリダイレクト
      redirect_to admin_item_path(@item.id)
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      # フラッシュメッセージを設定
      flash[:notice] = "商品は編集されました"
      redirect_to admin_items_path
    else
      render :edit
    end
  end

  private
  # ストロングパラメータ
  def item_params
    params.require(:item).permit(:name,:introduction,:price,:is_active,:image,:genre_id)
  end

end
