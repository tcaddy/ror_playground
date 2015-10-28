FactoryGirl.define do
  factory :album do |f|
    f.artist
    f.name      do
      (
        10.times.to_a.map{|n| Faker::App.name } - Album.where(artist_id: f.artist_id).map(&:name)
      ).sample
    end
  end

  factory :album_full, parent: :album do
    year      { Time.zone.today.year - (rand * 25).to_i }
    photo_url { Faker::Company.logo }
  end
end
