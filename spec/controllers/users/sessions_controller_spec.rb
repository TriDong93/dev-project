require "rails_helper"

describe Users::SessionsController, type: :controller do
  describe "#create" do
    let(:user) { create(:user) }

    before do
      request.env["devise.mapping"] = Devise.mappings[:user]
    end

    context "when user sign in" do
      context "When user sign in with a valid username and password" do
        before do
          process :create, method: :post, params: { user: { username: user.username, password: user.password } }
        end

        it { expect(response).to have_http_status(:redirect) }
        it { expect(controller).to set_flash[:notice].to("Signed in successfully.") }
      end

      context "When user cannot log in with an invalid password" do
        before do
          process :create, method: :post, params: { user: { username: user.username, password: "password" } }
        end

        it { expect(controller).to set_flash[:alert].to("Invalid Username or password.") }
      end
    end

    context "when user sign up" do
      context "when user sign up with a valid username and password" do
        before do
          process :create, method: :post, params: { user: { username: "username1", password: "password" } }
        end

        it { expect(controller).to set_flash[:notice].to("Welcome! You have signed up successfully.") }
      end
    end
  end
end
