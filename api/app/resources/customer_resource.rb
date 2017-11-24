class CustomerResource < JSONAPI::Resource
  attributes :first_name, :last_name, :address, :email
end
