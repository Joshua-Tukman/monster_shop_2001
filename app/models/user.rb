class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  has_secure_password
  validates_presence_of :name, :address, :city, :state, :zip, :password_confirmation

  enum role: {default: 0, merchant: 1, admin: 2}
end