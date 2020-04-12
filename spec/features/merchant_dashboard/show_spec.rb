require 'rails_helper'

RSpec.describe "As a merchant employee", type: :feature do
  describe "when I visit my dashboard show page" do
    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 80203)
      @dog_shop = Merchant.create(name: "Meg's Dog Shop", address: '123 Dog Rd.', city: 'Hershey', state: 'PA', zip: 80203)

      josh = bike_shop.users.create!(name: "Josh Tukman",
                            address: "756 Main St",
                            city: "Denver",
                            state: "Colorado",
                            zip: "80210",
                            email: "josh.t@gmail.com",
                            password: "secret_password",
                            password_confirmation: "secret_password",
                            role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(josh)
    end
    
    it "can show the name and full address of the merchant that I work for" do

      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 80203)
      dog_shop = Merchant.create(name: "Meg's Dog Shop", address: '123 Dog Rd.', city: 'Hershey', state: 'PA', zip: 80203)

      josh = bike_shop.users.create!(name: "Josh Tukman",
                            address: "756 Main St",
                            city: "Denver",
                            state: "Colorado",
                            zip: "80210",
                            email: "josh.t@gmail.com",
                            password: "secret_password",
                            password_confirmation: "secret_password",
                            role: 1)


      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(josh)
      # visit "/merchant/#{bike_shop.id}"
      visit "/merchant"

      expect(page).to have_content("Brian's Bike Shop")
      expect(page).to_not have_content("Meg's Dog Shop")
      expect(page).to have_content("Address: #{bike_shop.address}")
    end

    xit "I can click a link to view my own items" do
      # tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      # seat = @bike_shop.items.create!(name: "Seat", description: "Cushy for your tushy.", price: 199, image: "https://www.rei.com/media/product/153242", inventory: 20)
      # pump = @bike_shop.items.create!(name: "Pump", description: "Not just hot air", price: 70, image: "https://www.rei.com/media/product/152974", inventory: 20)
      
      # pull_toy = @dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      
      visit "/merchant"

      click_link "My Items"

      expect(current_path).to eq("/merchant/items")

      # expect
    end
  end
end

# User Story 36, Merchant's Items index page

# As a merchant employee
# When I visit my merchant dashboard
# I see a link to view my own items
# When I click that link
# My URI route should be "/merchant/items"