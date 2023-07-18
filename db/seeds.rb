# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


for i in 1..5
  Donation.create!(
    first_name: "Person #{1}",
    last_name: "Example",
    email: "person_#{i}@demo.com",
    birth_date: "04/04/1993",
    phone_number: "1234567",
    amount: 100000
  )
end

puts "Donations has been created."
