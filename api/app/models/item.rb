class Item < ApplicationRecord
  validates :quantity, presence: true

  belongs_to :order
  belongs_to :dish
end
