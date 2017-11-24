class Restaurant < ApplicationRecord
  validates(
    :name, 
    :contact_name, 
    :contact_phone, 
    :email, 
    :address, 
    :open_at,
    :close_at,
    :days_of_the_week,
    presence: true
  )
end
