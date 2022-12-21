class CartItem < ApplicationRecord

 belongs_to :item
 belongs_to :customer

 #カート内の商品合計に利用
 def sum_of_price
  item.price * amount
 end

end
