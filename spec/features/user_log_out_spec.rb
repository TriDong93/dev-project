require 'rails_helper'

RSpec.feature "User Log out", type: :feature do
  let(:user) { create(:user) }

  before { user_log_in(user) }

  scenario "User log out successfully" do
    visit root_path
    click_on "Logout"
    expect(page).to have_text("Signed out successfully")
  end
end
