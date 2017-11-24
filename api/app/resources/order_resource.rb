class OrderResource < JSONAPI::Resource
  after_create :dosomething
  attributes :deliver_late
  has_one :customer

  def dosomething
    #send_email
    #enqueue job
  end
end
