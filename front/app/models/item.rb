class Item < BaseResource
  property :quantity

  belongs_to :order
  belongs_to :dish
end
