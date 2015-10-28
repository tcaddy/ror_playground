require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SongsHelper. For example:
#
# describe SongsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe SongsHelper, type: :helper do
  describe '#song_duration' do
    it 'returns a formatted time duration' do
      [nil, 1, 61, 3_599, 3_601].each do |val|
        expect(helper.song_duration(val)).to eq(Song.song_duration(val))
      end
    end
  end
end
