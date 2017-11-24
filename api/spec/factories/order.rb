FactoryGirl.define do
  factory :order do
    deliver_late DateTime.now
    status 'initial'
  end
end
