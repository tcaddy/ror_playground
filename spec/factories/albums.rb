FactoryGirl.define do
  factory :album do
    artist
    name      {Faker::App.name}
  end
  factory :album_full, parent: :album do
    year      {Date.today.year-(rand*25).to_i}
    photo_url {Faker::Company.logo}
  end

end
