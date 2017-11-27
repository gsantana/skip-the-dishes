class OrdersController < ApplicationController

  def index
    @orders = Order.where(customer_id: customer_id).all
  end

  def create
    customer = current_customer

    if customer
      item  = Item.new(quantity: 1, dish_id: dish_id)
      order = Order.create(customer_id: customer.id,
                           deliver_late: DateTime.now,
                           items: [ JSON.parse(item.to_json) ])

      if order.persisted?
        flash[:success] = 'Your Order was registered!'
      else
        flash[:error] = 'Sorry, something went wrong!'
      end
      redirect_to root_path
    else
      flash[:info] = 'You are not logged'
      redirect_to customers_path
    end
  end

  def surprise
    customer = current_customer
    if customer
      uri = URI("#{endpoint}/customers/#{customer.id}/orders/surprise")

      result = Net::HTTP.post_form(uri, q: 'surprise')
      if result.code == '201'
        flash[:success] = 'Your surprise was sent. See the result in your email'
      else
        flash[:error] = 'Something went wrong!'
      end
      redirect_to root_path
    else
      flash[:info] = 'You are not logged'
      redirect_to customers_path
    end
  end

  private

  def customer_id
    session[:customer_id]
  end

  def endpoint
    ENV.fetch('API_URL', 'http://localhost:3000')
  end

  def order_params
    params.permit(:dish_id)
  end

  def dish_id
    order_params[:dish_id]
  end
end
