require 'random_word_generator'
FactoryGirl.define do
  factory :restaurant do
    name { RandomWordGenerator.word }
    contact_name "MyString"
    contact_phone "MyString"
    email "MyString"
    address "MyString"
    open_at "2017-11-24 00:42:36"
    close_at "2017-11-24 00:42:36"
    days_of_the_week 1
  end
end
