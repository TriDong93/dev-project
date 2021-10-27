require 'rails_helper'

RSpec.feature "User shares video", type: :feature do
  let(:user) { create(:user) }

  before { user_log_in(user) }

  after :each do
    Warden.test_reset!
  end

  scenario "When user share a video with valid youtube url" do
    visit root_path
    click_on "Share a movie"
    fill_in 'share_video_url', with: "youtube.com/watch?v=TVcdg2YvBw0"
    click_button "Share"

    expect(ShareVideo.count).to eq(1)
  end

  scenario "When user can't share a video with invalid youtube url" do
    visit root_path
    click_on "Share a movie"
    fill_in 'share_video_url', with: "http://youtube.com/watch?vi=dQw4w9WgXcQ"
    click_button "Share"

    expect(ShareVideo.count).to eq(0)
    expect(page).to have_text("Url is invalid")
  end
end
