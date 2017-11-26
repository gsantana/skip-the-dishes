# frozen_string_literal: true

class SurpriseOrderExecutorWorker
  include Sidekiq::Worker

  sidekiq_options :retry => true, :backtrace => true

  def perform(customer_id)
    customer = Customer.find customer_id 

    cluster_customers = CustomerCluster.where(centroid: customer.cluster.centroid)
    customers_orders = cluster_customers.map{|c| c.customer.orders }.flatten
    customers_items =  customers_orders.map{|c| c.items }.flatten
    dishes_ids = customers_items.map{|i| i.dish.id }
    groped_dishes_ids = dishes_ids.group_by(&:itself)
    dishes_rank = {}
    groped_dishes_ids.each{|k,v|dishes_rank[k] = v.count }
    dishes_rank = dishes_rank.sort_by {|_key, value| value}.reverse

    customer_dishes = customer.orders.map{|o| o.items }.flatten.map{|i| i.dish.id}.flatten
    dishes_rank.each do |dish|
      unless customer_dishes.include?(dish)
        dish_id = dish.first
        item = Item.new(quantity: 1, dish_id: dish_id)
        order = Order.new
        order.deliver_late = DateTime.now
        order.items << item
        customer.orders << order
        OrderMailer.order_processed_email(order).deliver_later
        return
      end
    end
  end
end
