require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  describe "associations" do
    it { is_expected.to have_many(:share_videos) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to_not validate_presence_of(:email) }
  end

  describe "DB settings" do
    it { have_db_index(:username) }
  end
end
