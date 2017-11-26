# frozen_string_literal: true

class OrderExecutorWorker
  include Sidekiq::Worker

  sidekiq_options :retry => true, :backtrace => true

  def perform(order_id)
    order = Order.find order_id 
    order.finish
  end
end
