# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require File.expand_path('../../lib/reset_auto_increment', __FILE__)
require File.expand_path('../../lib/lastfm_api', __FILE__)

# enter names of artists to use for seeding from LastFM
artist_names = ['The Beatles', 'Red Hot Chili Peppers', 'Phish', 'Ween']

# empty tables and reset auto increments
[Song,Album,Artist].each do |klass|
  klass.send(:delete_all)
  ResetAutoIncrement.reset klass.table_name
end

Artist.seed_artists_from_spotify artist_names
