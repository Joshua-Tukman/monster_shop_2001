require 'rails_helper'

RSpec.describe "As any registered user" do
  describe "As a default user" do
    it "can log out of the system" do
      user = User.create!(name: "Josh Tukman",
                            address: "756 Main St",
                            city: "Denver",
                            state: "Colorado",
                            zip: "80209",
                            email: "josh.t@gmail.com",
                            password: "secret_password",
                            password_confirmation: "secret_password",
                            role: 0)
      visit '/login'
      fill_in :email, with: "josh.t@gmail.com"
      fill_in :password, with: "secret_password"
      click_button "Submit"
      click_link "Logout"
      expect(current_path).to eq("/")
      expect(page).to have_content("You are logged out!")
    end
  end
  describe "As a merchant user" do
    it "can log out of the system" do
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 80203)

      josh = bike_shop.users.create!(name: "Josh Tukman",

                            address: "756 Main St",
                            city: "Denver",
                            state: "Colorado",
                            zip: "80209",
                            email: "josh.t@gmail.com",
                            password: "secret_password",
                            password_confirmation: "secret_password",
                            role: 1)
                            
      visit '/login'
      fill_in :email, with: "josh.t@gmail.com"
      fill_in :password, with: "secret_password"
      click_button "Submit"
      click_link "Logout"
      expect(current_path).to eq("/")
      expect(page).to have_content("You are logged out!")
    end
  end
  describe "As an admin user" do
    it "can log out of the system" do
      user = User.create!(name: "Josh Tukman",
                            address: "756 Main St",
                            city: "Denver",
                            state: "Colorado",
                            zip: "80209",
                            email: "josh.t@gmail.com",
                            password: "secret_password",
                            password_confirmation: "secret_password",
                            role: 2)
      visit '/login'
      fill_in :email, with: "josh.t@gmail.com"
      fill_in :password, with: "secret_password"
      click_button "Submit"
      click_link "Logout"
      expect(current_path).to eq("/")
      expect(page).to have_content("You are logged out!")
    end
  end
end
