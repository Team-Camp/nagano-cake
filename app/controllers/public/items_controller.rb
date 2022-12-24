class Public::ItemsController < ApplicationController

  before_action :authenticate_customer!, except: [:index,:show]


  def index
    @genres = Genre.all
    # @items = Item.all
    # @items = Item.page(params[:page])
    @items = Item.all
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items
      # @item = Item.page(params[:page])
    end

    # 一覧表示する商品の数を数えてます
    @count = 0
    @items.each do |item|
      if item.is_active == true
        @count = @count + 1
      end
    end
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.all

    if @item.is_active == false
      redirect_to items_path
    end
  end


  private

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :is_active)
  end
end