class DishResource < JSONAPI::Resource
  attributes :name, :price, :calories

  belongs_to :restaurant
end
