require 'rails_helper'

RSpec.describe "bulk_discounts index page", type: :feature do 
  before(:each) do 
    @m1 = Merchant.create!(name: "Gimli's Toy Bin")

    @discount1 = @m1.bulk_discounts.create!(name: "Autumn Leaves", percentage: 20, threshold: 10)
    @discount2 = @m1.bulk_discounts.create!(name: "Winter Break", percentage: 10, threshold: 20)
    @discount3 = @m1.bulk_discounts.create!(name: "Summer Vacay", percentage: 15, threshold: 15)

  end

  it "can show a list of all available discounts for this merchant" do 
    visit merchant_bulk_discounts_path(@m1)

    within "#all_discounts" do 
      expect(page).to have_content("Discount: Autumn Leaves")
      expect(page).to have_content("Percentage: 20%")
      expect(page).to have_content("Minimum Items: 10")
      
      expect(page).to have_content("Discount: Winter Break")
      expect(page).to have_content("Percentage: 10%")
      expect(page).to have_content("Minimum Items: 20")
      
      expect(page).to have_content("Discount: Summer Vacay")
      expect(page).to have_content("Percentage: 15%")
      expect(page).to have_content("Minimum Items: 15")
    end
  end

  it "has each discount name as a link to that discounts show page" do 
    visit merchant_bulk_discounts_path(@m1)

    within "#discount-#{@discount1.id}" do 
      expect(page).to have_link("Autumn Leaves")

      click_link "Autumn Leaves"

    end
    expect(current_path).to eq("/merchants/#{@m1.id}/bulk_discounts/#{@discount1.id}")
    
    visit merchant_bulk_discounts_path(@m1)

    within "#discount-#{@discount2.id}" do 
      expect(page).to have_link("Winter Break")

      click_link "Winter Break"

    end
    expect(current_path).to eq("/merchants/#{@m1.id}/bulk_discounts/#{@discount2.id}")

    visit merchant_bulk_discounts_path(@m1)

    within "#discount-#{@discount3.id}" do 
      expect(page).to have_link("Summer Vacay")

      click_link "Summer Vacay"
      
      expect(current_path).to eq("/merchants/#{@m1.id}/bulk_discounts/#{@discount3.id}")
    end
  end

  it "has a link to to create a new bulk discount - this link should direct to a form to create a new discount" do 
    visit merchant_bulk_discounts_path(@m1)

    within "#all_discounts" do 
      expect(page).to have_link("Add New Discount")

      click_link "Add New Discount"

      expect(current_path).to eq("/merchants/#{@m1.id}/bulk_discounts/new")
    end
  end
end