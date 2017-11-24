class Order < ApplicationRecord
  before_validation :set_default

  validates :deliver_late, :status, presence: true
  belongs_to :customer

  protected

  def set_default
    self.status = "initial" unless self.status
  end
end
