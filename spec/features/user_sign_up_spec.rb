require 'rails_helper'

RSpec.feature "User Sign up", type: :feature do
  after :each do
    Warden.test_reset!
  end

  scenario "User sign up successfully with valid username and password" do
    visit root_path
    fill_in 'user_username', with: "user123"
    fill_in 'user_password', with: "qwerty"
    click_button "Login / Register"

    expect(page).to have_text("Welcome! You have signed up successfully")
  end

  scenario "User sign up unsuccessfully with an invalid password" do
    visit root_path
    fill_in 'user_username', with: "user123" 
    fill_in 'user_password', with: "pass"
    click_button "Login / Register"

    expect(page).to have_text("Password is too short")
  end
end
