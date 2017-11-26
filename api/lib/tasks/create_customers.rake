
# frozen_string_literal: true

namespace :customers do
  desc('create custumers')
  task :create, [:number] => [:environment] do |_, args|
    puts '-- started creation'
    number = args.fetch(:number).to_i
    (1..number).each do  
      customer = FactoryGirl.create(:customer)
      Rake::Task["orders:create"].execute({order_number: rand(20), customer_id:customer.id})
    end
    puts '-- finished creation'
  end
end
