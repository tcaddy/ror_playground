require 'rails_helper'

RSpec.describe Song, type: :model do
  it 'has a factory for testing' do
    expect(build(:song)).to be_valid
    expect(build(:song_full)).to be_valid
  end

  let(:song) { build(:song) }
  let(:song_full) { build(:song_full) }
  describe 'ActiveModel validations' do
    it { expect(song).to validate_presence_of(:name) }
  end

  describe 'ActiveRecord associations' do
    it { expect(song).to belong_to(:album) }
  end

  describe 'public class methods' do
    context 'responds to its methods' do
      it { expect(Song).to respond_to(:parse_duration) }
      it { expect(Song).to respond_to(:song_duration) }
    end

    context 'executes methods correctly' do
      let(:items) do
        [
          {
            string: '00:01',
            integer: 1
          },
          {
            string: '01:05',
            integer: 65
          },
          {
            string: '10:05',
            integer: 605
          },
          {
            string: '01:01:01',
            integer: 3661
          }
        ]
      end
      context 'Song.parse_duration' do
        let(:parse_duration_items) { [{string: 123, integer: 123}] }
        it 'parses a string duration to seconds' do
          (items + parse_duration_items).each do |h|
            expect(Song.parse_duration(h[:string])).to eq(h[:integer])
          end
        end
      end
      context 'Song.song_duration' do
        it 'returns a formatted time duration' do
          expect(Song.song_duration).to be_nil
          expect(Song.song_duration(1)).to eq('00:01')
          expect(Song.song_duration(61)).to eq('01:01')
          expect(Song.song_duration(3599)).to eq('59:59')
          expect(Song.song_duration(3601)).to eq('01:00:01')
          items.each do |h|
            expect(Song.song_duration(h[:integer])).to eq(h[:string])
          end
        end
      end
    end
  end
end
