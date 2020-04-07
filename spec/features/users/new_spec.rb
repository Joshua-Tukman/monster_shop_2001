require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "When I click on the 'register' link in the nav bar" do
    it "takes me to the user registration page" do
      visit "/merchants"
      within ".topnav" do
        click_link "Register"
      end
      expect(current_path).to eq("/register")
    end
    it "lets me complete a new registration form" do
      visit "/register"
        fill_in :name, with: "Josh Tukman"
        fill_in :address, with: "756 Main St"
        fill_in :city, with: "Denver"
        fill_in :state, with: "Colorado"
        fill_in :zip, with: "80209"
        fill_in :email, with: "josh.t@gmail.com"
        fill_in :password, with: "secret_password"
        fill_in :password_confirmation, with: "secret_password"

        click_button "Register"
        expect(current_path).to eq("/profile")
        within ".success-flash" do
          expect(page).to have_content("You are now registered and logged in!")
        end
      end

      it "if I don't fill in all fields I see a flash message and returned to the registration page" do
        visit "/register"

        fill_in :name, with: "Josh Tukman"
        fill_in :address, with: ""
        fill_in :city, with: "Denver"
        fill_in :state, with: "Colorado"
        fill_in :zip, with: "80209"
        fill_in :email, with: ""
        fill_in :password, with: "secret_password"
        fill_in :password_confirmation, with: "secret_password"

        click_button "Register"

        expect(current_path).to eq("/register")

        within ".error-flash" do
          expect(page).to have_content("ERROR!")
        end
    end
  end
end
