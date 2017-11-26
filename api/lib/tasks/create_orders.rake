# frozen_string_literal: true
namespace :orders do
  desc('create orders')
  task :create, [:order_number, :customer_id] => [:environment] do |_, args|
    puts '-- started creation'
    customer = Customer.find(args.fetch(:customer_id).to_i)
    number = args.fetch(:order_number).to_i
    (1..number).each do |_| 
      dish_id =  rand(Dish.count)
      item = FactoryGirl.build(:item)
      item.dish = Dish.find(dish_id)
      item.quantity = 1 + rand(5)
      order = FactoryGirl.build(:order)
      order.items << item
      customer.orders << order
    end
    puts '-- finished creation'
  end
end
