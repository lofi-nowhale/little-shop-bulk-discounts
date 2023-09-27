require 'rails_helper' 

RSpec.describe "the bulk dicsount editor" do 
  before :each do
    @m1 = Merchant.create!(name: "Gimli's Toy Bin")

    @discount1 = @m1.bulk_discounts.create!(name: "Autumn Leaves", percentage: 20, threshold: 10)
    @discount2 = @m1.bulk_discounts.create!(name: "Winter Break", percentage: 10, threshold: 20)
    @discount3 = @m1.bulk_discounts.create!(name: "Summer Vacay", percentage: 15, threshold: 15)
  end

  it "can edit the item" do 
    visit "/merchants/#{@m1.id}/bulk_discounts/#{@discount1.id}"

    click_button "Edit Autumn Leaves"

    fill_in "Name", with: 'Fall Festival'
    fill_in "Percentage", with: '30'
    fill_in "Threshold", with: '30'
    click_button "Update Discount"

    expect(current_path).to eq("/merchants/#{@m1.id}/bulk_discounts")

    within "#all_discounts" do 
      expect(page). to have_content("Discount: Fall Festival")
      expect(page). to have_content("Percentage: 30%")
      expect(page). to have_content("Minimum Items: 30")
    end

  end
  it "can flash an error if the item hasn't been successfully created" do 
    visit "/merchants/#{@m1.id}/bulk_discounts/#{@discount1.id}"

    click_button "Edit Autumn Leaves"

    fill_in "Name", with: 'Fall Festival'
    fill_in "Percentage", with: ''
    fill_in "Threshold", with: '30'
    click_button "Update Discount"

    expect(current_path).to eq("/merchants/#{@m1.id}/bulk_discounts/#{@discount1.id}/edit")

    expect(page).to have_content("Error: All fields must be filled in to submit")

  end
end