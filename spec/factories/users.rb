FactoryGirl.define do
  factory :user do
    email               { Faker::Internet.email }
    password            'abcd1234'
    sign_in_count       0
  end

end
