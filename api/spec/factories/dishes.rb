FactoryGirl.define do
  factory :dish do
    name { RandomWordGenerator.word }
    price { (10 + rand(200)) } 
    calories { (500 + rand(1500)) } 
  end
end
