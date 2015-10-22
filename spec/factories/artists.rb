require File.expand_path('../../rails_helper', __FILE__)

FactoryGirl.define do
  factory :artist do
    name       {Faker::Company.name}
  end
end