class OrdersController < ApplicationController


  def create
    order = Order.new(order_params)
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
    params[:data][:attributes].permit(:deliver_late, :customer_id)
  end

  def customer_id
    params[:customer_id]
  end

  def items_params
    params[:data][:attributes][:items]
  end

  def items
    items_params.map do |i|
      item_attr = i[:attributes].permit!
      Item.new item_attr
    end
  end

  def serialize(order)
    JSONAPI::ResourceSerializer.new(OrderResource)
    .serialize_to_hash(OrderResource.new(order, nil))
  end
end
