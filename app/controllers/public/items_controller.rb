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
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.all
  end


  private

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :is_active)
  end
end