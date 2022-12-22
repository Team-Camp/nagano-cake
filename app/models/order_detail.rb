class OrderDetail < ApplicationRecord

  # アソシエーションの記述
  belongs_to :order
  belongs_to :item

end
