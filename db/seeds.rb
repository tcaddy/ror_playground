# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require File.expand_path('../../lib/reset_auto_increment', __FILE__)

# empty tables and reset auto increments
[Song,Album,Artist].each do |klass|
  klass.send(:delete_all)
  ResetAutoIncrement.reset klass.table_name
end

phish = Artist.create! name: 'Phish'
tlg = Artist.create! name: 'Tea Leaf Green'
rhcp = Artist.create! name: 'Red Hot Chili Peppers'

arr = []
arr << {
  album: {
    name: 'Junta',
    year: 1989,
    artist_id: phish.id,
    photo_url: 'https://upload.wikimedia.org/wikipedia/en/thumb/c/c8/PhishJunta88.jpg/220px-PhishJunta88.jpg'
  },
  songs: [
    {name: 'Fee',duration: '5:23',disk: 1},
    {name: 'You Enjoy Myself',duration: '9:47',disk: 1},
    {name: 'Esther',duration: '9:21',disk: 1},
    {name: 'Golgi Apparatus',duration: '4:35',disk: 1},
    {name: 'Foam',duration: '6:50',disk: 1},
    {name: 'Dinner and a Movie',duration: '3:42',disk: 1},
    {name: 'The Divided Sky',duration: '11:50',disk: 1},
    {name: 'David Bowie',duration: '10:59',disk: 1},
    {name: 'Fluffhead',duration: '3:14',disk: 2},
    {name: "Fluff's Travels",duration: '11:35',disk: 2},
    {name: 'Contact',duration: '6:42',disk: 2},
    {name: 'Union Federal',duration: '25:31',disk: 2},
    {name: 'Sanity',duration: '8:22',disk: 2},
    {name: 'Icculus',duration: '4:24',disk: 2}
  ]
}
arr << {
  album: {
    name: 'Tea Leaf Green',
    year: 1999,
    artist_id: tlg.id,
    photo_url: nil
  },
  songs: [
    {name: "Steal Your Imagination",duration: '3:52'},
    {name: "Cherry Red Guitar",duration: '4:23'},
    {name: "Apocalyptic Cowboy",duration: '5:24'},
    {name: "California",duration: '4:31'},
    {name: "Crackers and Cheese",duration: '3:47'},
    {name: "Professor's Blues",duration: '7:11'},
    {name: "New Year's Eve",duration: '4:55'},
    {name: "Ocean View",duration: '5:19'},
    {name: "Boomtown",duration: '4:43'},
    {name: "Passion",duration: '4:42'},
    {name: "Asphalt Funk",duration: '4:39'},
    {name: "Turn the Page",duration: '3:57'}
  ]
}
arr << {
  album: {
    name: 'Lawn Boy',
    year: 1990,
    artist_id: phish.id,
    photo_url: 'https://upload.wikimedia.org/wikipedia/en/thumb/e/ef/Lawn_Boy_cover.jpg/220px-Lawn_Boy_cover.jpg'
  },
  songs: [
    {name: 'The Squirming Coil',duration: '6:02'},
    {name: 'Reba',duration: '12:26'},
    {name: 'My Sweet One',duration: '2:09'},
    {name: 'Split Open and Melt',duration: '4:42'},
    {name: 'The Oh Kee Pa Ceremony',duration: '1:41'},
    {name: 'Bathtub Gin',duration: '4:29'},
    {name: 'Run Like an Antelope',duration: '9:50'},
    {name: 'Lawn Boy',duration: '2:31'},
    {name: 'Bouncing Around the Room',duration: '3:55'}
  ]
}
arr << {
  album: {
    name: 'Midnight On the Reservoir',
    year: 2001,
    artist_id: tlg.id,
    photo_url: nil
  },
  songs: [
  ]
}
arr << {
  album: {
    name: 'One Hot Minute',
    year: 1995,
    artist_id: rhcp.id,
    photo_url: 'https://upload.wikimedia.org/wikipedia/en/thumb/8/8a/Rhcp7.jpg/220px-Rhcp7.jpg'
  },
  songs: [
    {name: "Warped",duration: '5:04'},
    {name: "Aeroplane",duration: '4:45'},
    {name: "Deep Kick",duration: '6:33'},
    {name: "My Friends",duration: '4:02'},
    {name: "Coffee Shop",duration: '3:08'},
    {name: "Pea",duration: '1:47'},
    {name: "One Big Mob",duration: '6:02'},
    {name: "Walkabout",duration: '5:07'},
    {name: "Tearjerker",duration: '4:19'},
    {name: "One Hot Minute",duration: '6:23'},
    {name: "Falling into Grace",duration: '3:48'},
    {name: "Shallow Be Thy Game",duration: '4:33'},
    {name: "Transcending",duration: '5:46'}
  ]
}
arr << {
  album: {
    name: 'Californication',
    year: 1999,
    artist_id: rhcp.id,
    photo_url: 'https://upload.wikimedia.org/wikipedia/en/thumb/d/df/RedHotChiliPeppersCalifornication.jpg/220px-RedHotChiliPeppersCalifornication.jpg'
  },
  songs: [
    {name: "Around the World",duration: '3:58'},
    {name: "Parallel Universe",duration: '4:30'},
    {name: "Scar Tissue",duration: '3:35'},
    {name: "Otherside",duration: '4:15'},
    {name: "Get on Top",duration: '3:18'},
    {name: "Californication",duration: '5:21'},
    {name: "Easily",duration: '3:51'},
    {name: "Porcelain",duration: '2:43'},
    {name: "Emit Remmus",duration: '4:00'},
    {name: "I Like Dirt",duration: '2:37'},
    {name: "This Velvet Glove",duration: '3:45'},
    {name: "Savior",duration: '4:52'},
    {name: "Purple Stain",duration: '4:13'},
    {name: "Right on Time",duration: '1:52'},
    {name: "Road Trippin'",duration: '3:25'}
  ]
}
arr.each do |hash|
  album = Album.create! hash[:album]
  hash[:songs].each_with_index do |song,i|
    opts = {
      album_id: album.id,
      name: song[:name],
      duration: Song.parse_duration(song[:duration]),
      track: i+1
    }
    opts[:disk] = song[:disk] if song[:disk]
    Song.create! opts
  end
end