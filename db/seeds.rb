# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Rake::Task["csv_load:all"].invoke

@discount1 = BulkDiscount.create!(name: "Autumn Leaves", percentage: 20, threshold: 10, merchant_id: 1)
@discount2 = BulkDiscount.create!(name: "Winter Break", percentage: 10, threshold: 20, merchant_id: 1)
@discount3 = BulkDiscount.create!(name: "Summer Vacay", percentage: 15, threshold: 15, merchant_id: 1)