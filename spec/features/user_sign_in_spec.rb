require 'rails_helper'

RSpec.feature "User Login", type: :feature do
  let(:user) { create(:user) }

  after :each do
    Warden.test_reset!
  end

  scenario "User logs in successfully" do
    visit root_path
    fill_in 'user_username', with: user.username 
    fill_in 'user_password', with: user.password
    click_button "Login / Register"

    expect(page).to have_text("Signed in successfully")
  end

  scenario "User login failed with an invalid password" do
    visit root_path
    fill_in 'user_username', with: user.username 
    fill_in 'user_password', with: "password"
    click_button "Login / Register"

    expect(page).to have_text("Invalid Username or password")
  end
end
