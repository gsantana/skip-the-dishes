class SessionsController < ApplicationController

  def login
    customer = Customer.find(customer_id).first
    if customer
      session[:customer_id] = customer.id
      redirect_to restaurants_path
    else
      flash.now[:danger] = 'Invalid Customer'
      redirect_to customers_path
    end
  end

  def logout
    session[:customer_id] = nil
    redirect_to customers_path
  end

  private

  def customer_id
    params[:customer_id]
  end

end
