require 'rails_helper'

RSpec.describe "As a merchant employee when I visit my items page", type: :feature do
  before(:each) do
    @bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

    @josh = @bike_shop.users.create!(name: "Josh Tukman",
                                     address: "756 Main St",
                                     city: "Denver",
                                     state: "Colorado",
                                     zip: "80210",
                                     email: "josh.t@gmail.com",
                                     password: "secret_password",
                                     password_confirmation: "secret_password",
                                     role: 1)

    @buyer = User.create!(name: "Purchaser",
                                     address: "756 Main St",
                                     city: "Denver",
                                     state: "Colorado",
                                     zip: "80210",
                                     email: "purchaser@example.com",
                                     password: "password",
                                     password_confirmation: "password",
                                     role: 0)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@josh)

    @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @seat = @bike_shop.items.create(name: "Seat", description: "Cushy for your tushy.", price: 199, image: "https://www.rei.com/media/product/153242", inventory: 20)
    @pump = @bike_shop.items.create(name: "Pump", description: "Not just hot air", price: 70, image: "https://www.rei.com/media/product/152974", inventory: 20)
    # @pedals = @bike_shop.items.create(name: "Pedals", description: "Clipless bliss!", price: 210, image: "https://www.rei.com/media/product/130015", inventory: 20)
    # @helmet = @bike_shop.items.create(name: "Helmet", description: "Safety Third!", price: 100, image: "https://www.rei.com/media/product/153004", inventory: 20)
    # @stud = @bike_shop.items.create(name: "Canti Studs", description: "You don't need 'em till you do.'", price: 5, image: "https://www.jensonusa.com/globalassets/product-images---all-assets/problem-solvers/br309z00.jpg", active?:false, inventory: 4)
  
    @order1 = @buyer.orders.create!(name: 'Buyer', address: '123 Buyer Ave', city: 'Broomfield', state: 'CO', zip: 82345)
    @order2 = @josh.orders.create!(name: 'Josh', address: '123 Josh Ave', city: 'Broomfield', state: 'CO', zip: 82345)
      
    @order1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2, status: "Unfulfilled")
    @order2.item_orders.create!(item: @seat, price: @seat.price, quantity: 2, status: "Unfulfilled")
  
  end

  it "I see delete button next to each item that has never been ordered" do
    visit "merchant/items"
    
    within "#item-#{@pump.id}" do
      expect(@pump.has_orders?).to eq(false)
      expect(page).to have_button("Delete Item")
    end
    
    within "#item-#{@tire.id}" do
      expect(@tire.has_orders?).to eq(true)
      expect(page).not_to have_button("Delete Item")
    end

    within "#item-#{@seat.id}" do
      expect(@seat.has_orders?).to eq(true)
      expect(page).not_to have_button("Delete Item")
    end
  end

  describe "Clicking item delete button returns me to my items page" do
    it "where I see flash message and that item no longer on the page"do
    end
  end

end
# As a merchant employee
# When I visit my items page

# I see a button or link to delete the item next to each item that has never been ordered

# When I click on the "delete" button or link for an item
# I am returned to my items page
# I see a flash message indicating this item is now deleted
# I no longer see this item on the page