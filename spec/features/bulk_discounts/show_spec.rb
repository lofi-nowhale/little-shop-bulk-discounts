require 'rails_helper'

RSpec.describe "bulk discounts" do 
  before(:each) do 
    @m1 = Merchant.create!(name: "Gimli's Toy Bin")

    @discount1 = @m1.bulk_discounts.create!(name: "Autumn Leaves", percentage: 20, threshold: 10)
    @discount2 = @m1.bulk_discounts.create!(name: "Winter Break", percentage: 10, threshold: 20)
    @discount3 = @m1.bulk_discounts.create!(name: "Summer Vacay", percentage: 15, threshold: 15)
  end
  it "can show all the bulk_discount details" do 
    visit "/merchants/#{@m1.id}/bulk_discounts/#{@discount1.id}"

    within "#details" do 
       expect(page).to have_content("Name: Autumn Leaves")
      expect(page).to have_content("Percentage: 20%")
       expect(page).to have_content("Threshold: 10 Items")
    end
  end
end
