class Dish < ApplicationRecord
  validates :name, :price, presence: true

  belongs_to :restaurant
  has_many :items
end
