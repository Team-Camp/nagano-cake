class Item < ApplicationRecord
  # 画像を保存できるように記述
  has_one_attached :image

  # 中間テーブル（注文詳細）とのアソシエーションの記述
  has_many :order_details
  has_many :orders, through: :order_details
  has_many :cart_items

  # バリデーション
  validates :genre_id,presence: true
  validates :name,presence: true
  validates :introduction,presence: true
  validates :price,presence: true
  validates :is_active,presence: true

  # genreに対して多対１の記述
  belongs_to :genre

  #税率記載(濱岡)
  #ceilは切り上げ、floorが切り捨て、roundが四捨五入
  def with_tax_price
  (price * 1.1).floor
  end
end
