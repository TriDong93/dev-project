require "rails_helper"

describe ShareVideosController, type: :controller do
  describe "#new" do
    context "NOT logged in" do
      before do
        process :new, method: :get
      end

      it { expect(response).to have_http_status(:redirect) }
    end

    context "Logged in" do
      let(:user) { create(:user) }

      before do
        sign_in user
        process :new, method: :get
      end

      after do
        sign_out user
      end

      it { expect(response).to have_http_status(:success) }
    end
  end

  describe "#create" do
    context "NOT logged in" do
      before do
        process :create, method: :post, params: { share_video: { url: "youtube.com/watch?v=TVcdg2YvBw0" } }
      end

      it { expect(response).to have_http_status(:redirect) }
    end

    context "When user share a video with valid youtube url" do
      let(:user) { create(:user) }

      before do
        sign_in user
        process :create, method: :post, params: { share_video: { url: "youtube.com/watch?v=TVcdg2YvBw0" } }
      end

      after do
        sign_out user
      end

      it { expect(response).to redirect_to(root_path) }
      it { expect(ShareVideo.count).to eq(1) }
    end

    context "When user can not share a video with invalid youtube url" do
      let(:user) { create(:user) }

      before do
        sign_in user
        process :create, method: :post, params: { share_video: { url: "http://youtube.com/watch?vi=dQw4w9WgXcQ" } }
      end

      after do
        sign_out user
      end

      it { expect(ShareVideo.count).to eq(0) }
    end
  end
end
