# frozen_string_literal: true
require 'random_word_generator'

namespace :dishes do
  desc('create dishes')
  task :create, [:number] => [:environment] do |_, args|
    puts '-- started creation'
    restaurant = FactoryGirl.build(:restaurant)
    number = args.fetch(:number).to_i
    (1..number).each{ |_| restaurant.dishes <<(FactoryGirl.build(:dish)) }
    puts '-- finished creation'
  end
end
