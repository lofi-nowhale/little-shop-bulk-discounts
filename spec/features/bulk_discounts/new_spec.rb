require "rails_helper"

describe "Merchant Bulk Discount New" do
  before :each do
    @m1 = Merchant.create!(name: "Gimli's Toy Bin")

    @discount1 = @m1.bulk_discounts.create!(name: "Autumn Leaves", percentage: 20, threshold: 10)
    @discount2 = @m1.bulk_discounts.create!(name: "Winter Break", percentage: 10, threshold: 20)
    @discount3 = @m1.bulk_discounts.create!(name: "Summer Vacay", percentage: 15, threshold: 15)
  end
  
  it "should be able to fill in a form and create a new discount" do
    visit "/merchants/#{@m1.id}/bulk_discounts/new"

    fill_in :name, with: "Spring Break"
    fill_in :percentage, with: 10
    fill_in :threshold, with: 5

    click_button "Submit"

    expect(current_path).to eq("/merchants/#{@m1.id}/bulk_discounts")
    expect(page).to have_content("Spring Break")
    expect(page).to have_content("Bulk Discount Has Been Created!")
  end

  it "should be able to flash an error message if the form has missing fields upon submission" do
    visit "/merchants/#{@m1.id}/bulk_discounts/new"

    fill_in :name, with: "Spring Break"

    fill_in :threshold, with: "5"

    click_button "Submit"

    expect(current_path).to eq("/merchants/#{@m1.id}/bulk_discounts/new")
    expect(page).to have_content("WARNING: DISCOUNT HAS NOT BEEN CREATED! PLEASE FILL OUT ALL FIELDS AND RE-SUBMIT!")
  end
end
