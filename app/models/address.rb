class Address < ApplicationRecord

  # バリデーション
  validates :customer_id,presence: true
  validates :postal_code,presence: true,numericality: {only_integer: true}
  validates :address,presence: true
  validates :name,presence: true

  # customerとaddressは1対多の関係
  belongs_to :customer
  
  def address_display
  '〒' + postal_code + ' ' + address + ' ' + name
  end
  
end