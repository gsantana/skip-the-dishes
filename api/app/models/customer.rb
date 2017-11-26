class Customer < ApplicationRecord
  validates :first_name, :last_name, :address, :email, presence: true

  has_many :orders
  has_one :cluster, class_name: 'CustomerCluster'
end
