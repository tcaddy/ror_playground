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
  describe "#song_duration" do
    it "returns a formatted time duration" do
      expect(helper.song_duration).to be_nil
      expect(helper.song_duration(1)).to eq('00:01')
      expect(helper.song_duration(61)).to eq('01:01')
      expect(helper.song_duration(3599)).to eq('59:59')
      expect(helper.song_duration(3601)).to eq('01:00:01')
    end
  end
end
