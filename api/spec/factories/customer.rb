require 'random_word_generator'
FactoryGirl.define do
  factory :customer do
    first_name { RandomWordGenerator.word }
    last_name { RandomWordGenerator.word }
    address "Sao Paulo"
    email "johndoe@gmail.com"
  end
end
