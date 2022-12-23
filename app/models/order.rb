class Order < ApplicationRecord
  belongs_to :customer

  # 中間テーブル（注文詳細）とのアソシエーションの記述
  has_many :order_details
  has_many :items, through: :order_details
  has_one_attached :image
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :name, presence: true
  

  enum status: {
    "wait_payment":0,
    "confirm_payment":1,
    "making":2,
    "preparing_ship":3,
    "finish_prepare":4
  }

  enum payment_method: {
    "credit_card":0,
    "transfer":1
  }

  #商品の合計合計金額に利用
  def sum_of_price
    item.with_tax_price * amount
  end
end
