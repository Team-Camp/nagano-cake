class OrderDetail < ApplicationRecord

  # アソシエーションの記述
  belongs_to :order
  belongs_to :item

  # enumの記述
  enum making_status:{
    "cannot_start":0,
    "waiting_for_production":1,
    "in_production":2,
    "finished":3
  }

end
