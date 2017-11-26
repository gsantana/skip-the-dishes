class Customer < BaseResource
  property :first_name, type: :string
  property :last_name, type: :string
  property :address, type: :string
  property :email, type: :string

  has_many :orders
end
