module ApplicationHelper
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
