FactoryGirl.define do
  factory :song do
    album
    name      {Faker::App.name}
    track     {(1..15).to_a.sample}
  end
  factory :song_full, parent: :song do
    disk      {[1,2,3].sample}
    duration  {(30..600).to_a.sample}
  end

end
