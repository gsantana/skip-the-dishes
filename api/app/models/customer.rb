class Customer < ApplicationRecord
  validates :first_name, :last_name, :address, :email, presence: true

  has_many :orders
end
