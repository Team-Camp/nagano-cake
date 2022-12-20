class Item < ApplicationRecord
  # 画像を保存できるように記述
  has_one_attached :image

  # バリデーション
  validates :genre_id,presence: true
  validates :name,presence: true
  validates :introduction,presence: true
  validates :price,presence: true
  validates :is_active,presence: true

  # genreに対して多対１の記述
  belongs_to :genre
end
