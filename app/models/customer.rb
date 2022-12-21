class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true
  validates :encrypted_password, presence: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :postal_code, presence: true, numericality: {only_integer: true}
  validates :address, presence: true
  validates :telephone_number, presence: true, numericality: {only_integer: true}

 has_many :addresses, dependent: :destroy

 #カートアイテムの記載（濱岡）
 has_many :cart_items, dependent: :destroy

   def active_for_authentication?
    super && (is_deleted == false)
   end

end