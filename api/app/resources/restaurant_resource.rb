class RestaurantResource < JSONAPI::Resource
  attributes(
    :name,
    :contact_name,
    :contact_phone,
    :email,
    :address,
    :open_at,
    :close_at,
    :days_of_the_week
  )

  has_many :dishes
end
