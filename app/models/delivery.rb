class Delivery < ApplicationRecord

  belongs_to :user

  validates :first_name,presence:true
  validates :last_name, presence: true
  validates :first_name_kana, presence: true
  validates :last_name_kana, presence: true
  validates :postal_code, presence: true
  validates :area, presence: true
  validates :city, presence: true
  validates :address, presence: true

end
