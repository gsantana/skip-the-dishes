class Dish < ApplicationRecord
  validates :name, :price, presence: true

  belongs_to :restaurant

  has_one :cluster, class_name: 'DishCluster'
end
