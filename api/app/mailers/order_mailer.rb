class OrderMailer < ApplicationMailer
  default from: 'notifications@skipthedishes.com'

  def order_processed_email(order)
    @order = order
    mail(to: order.customer.email, subject: 'Your order was precessed')
  end
end
