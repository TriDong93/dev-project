module Features
  module SessionHelpers
    def user_log_in(user = nil)
      user = FactoryBot.create :user if user.nil?
      visit root_path
      expect(page).to have_button('Login / Register')
      fill_in 'user_username', with: user.username 
      fill_in 'user_password', with: user.password
      click_button "Login / Register"
    end
  end
end
