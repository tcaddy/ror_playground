FactoryGirl.define do
  factory :artist do
    name       {Faker::Company.name}
  end
end