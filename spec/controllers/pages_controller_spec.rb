require "rails_helper"

describe PagesController, type: :controller do
  describe "#index" do
    before do
      process :index, method: :get
    end

    it { expect(response).to be_successful }
  end
end
