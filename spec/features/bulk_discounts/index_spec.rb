require 'rails_helper'

RSpec.describe "bulk_discounts index page", type: :feature do 
  before(:each) do 
    @m1 = Merchant.create!(name: "Gimli's Toy Bin")

    @discount1 = BulkDiscount.create!(name: "Autumn Leaves", percentage: 20, threshold: 10, merchant_id: @m1.id)
    @discount2 = BulkDiscount.create!(name: "Winter Break", percentage: 10, threshold: 20, merchant_id: @m1.id)
    @discount2 = BulkDiscount.create!(name: "Summer Vacay", percentage: 15, threshold: 15, merchant_id: @m1.id)
  end

  it "can show a list of all available discounts for this merchant" do 
    visit "/merchants/#{@m1.id}/bulk_discounts"
    within "#all_discounts" do 
      expect(page).to have_content("Discount: Autumn Leaves")
      expect(page).to have_content("Discount: Winter Break")
      expect(page).to have_content("Discount: Summer Vacay")
    end

  end
end