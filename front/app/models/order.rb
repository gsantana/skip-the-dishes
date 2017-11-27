class Order < BaseResource
  property :deliver_late

  belongs_to :customer
  has_many :items
end
