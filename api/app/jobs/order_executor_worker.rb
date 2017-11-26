# frozen_string_literal: true

class OrderExecutorWorker
  include Sidekiq::Worker

  sidekiq_options :retry => true, :backtrace => true

  def perform(order_id)
    order = Order.find order_id 

    return true if order.finished?

    order.finish
    OrderMailer.order_processed_email(order).deliver_later
  end
end
