require 'rails_helper'

RSpec.describe ShareVideo, type: :model do
  subject(:share_video) { build(:share_video) }

  describe "associations" do
    it { is_expected.to belong_to(:user) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:url) }

    context "With valid youtube url" do
      valid_youtube_urls = [
        'youtube.com/watch?v=TVcdg2YvBw0',
        'http://youtu.be/TVcdg2YvBw0',
        'https://www.youtube.com/embed/TVcdg2YvBw0',
        'http://youtube.com/v/TVcdg2YvBw0'
      ]

      valid_youtube_urls.each do |youtube_url|
        let(:share_video) { build(:share_video, url: youtube_url) }
        it { expect(share_video).to be_valid }
        it { expect(share_video.youtube_id).to eq('TVcdg2YvBw0') }
      end
    end

    context "With invalid youtube url" do
      invalid_youtube_urls = [
        'www.youtube.com/',
        'http://youtube.com/watch?vi=dQw4w9WgXcQ',
        'http://youtube.com/?view=oTJRivZTMLs&feature=channel'
      ]

      invalid_youtube_urls.each do |youtube_url|
        let(:share_video) { build(:share_video, url: youtube_url) }
        it { expect(share_video).to_not be_valid }
        it { expect(share_video.youtube_id).to eq(nil) }
      end
    end
  end
end
