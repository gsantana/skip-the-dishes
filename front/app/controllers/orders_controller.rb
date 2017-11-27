class OrdersController < ApplicationController
  def create
    customer = current_customer
    unless customer
      flash[:error] = 'Sorry, your session has expired'
      redirect_to root_path
    end

    item  = Item.new(quantity: 1, dish_id: dish_id)
    order = Order.create(customer_id: customer.id, deliver_late: DateTime.now, items: [ JSON.parse(item.to_json) ])

    if order.persisted?
      flash[:success] = 'Your Order was registered!'
    else
      flash[:error] = 'Sorry, something went wrong!'
    end

    redirect_to root_path
  end

  private

  def order_params
    params.permit(:dish_id)
  end

  def dish_id
    order_params[:dish_id]
  end
end
