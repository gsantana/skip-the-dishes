class OrdersController < ApplicationController


  def create
    order = Order.new(order_params)
    order.customer = Customer.find(customer_id)
    order.items << items
    order.save
    OrderExecutorWorker.perform_at(order.deliver_late, order.id)
    render json: serialize(order), status: :created
  rescue => e
    render json: {errors: e.message }, status: :unprocessable_entity
  end

  def surprise_order
    SurpriseOrderExecutorWorker.perform_async(params[:customer_id])
    render json: {message: 'ok'}, status: :created
  end

  private

  def order_params
    params[:data][:attributes].permit!
  end

  def customer_id
    params[:data][:relationships][:customer][:data][:id]
  end

  def items_params
    params[:data][:relationships][:items][:data]
  end

  def items
    items_params.map do |i| 
      dish_id = i[:relationships][:dish][:id]
      item_attr = i[:attributes].permit!
      Item.new({dish_id: dish_id }.merge(item_attr))
    end
  end

  def serialize(order)
    JSONAPI::ResourceSerializer.new(OrderResource)
    .serialize_to_hash(OrderResource.new(order, nil))
  end
end
