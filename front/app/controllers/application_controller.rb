class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_customer
    if session[:customer_id]
      Customer.find(session[:customer_id]).first
    else
      nil
    end
  end

  def session_present?
    session[:customer_id]
  end
end
