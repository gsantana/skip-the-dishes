class CustomerResource < JSONAPI::Resource
  attributes :first_name, :last_name, :address, :email

  has_many :orders
end
