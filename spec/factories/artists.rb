require File.expand_path('../../factory_helper', __FILE__)

FactoryGirl.define do
  factory :artist do
    name       {Faker::Company.name}
  end
end