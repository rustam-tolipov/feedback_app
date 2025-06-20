# For making sure everything working as expected I add seeds data for models

puts "🌱🌱🌱🌱🌱🌱🌱 SEEDING.... 🌱🌱🌱🌱🌱🌱🌱"

# making sure there is no leftover date
Feedback.delete_all
User.delete_all
Product.delete_all

# Creating users, with random data
puts "Adding random users..."
users = Array.new(50) do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email
  )
end

# Just random products
puts "Add products..."
products = Array.new(200) do
  Product.create!(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph(sentence_count: 2)
  )
end

# So this time I added feedbacks with random products and users that we seeded before
puts "Feedbacks that for products created above with users that we specified"
500.times do
  Feedback.create!(
    rating: rand(1..5),
    comment: [ Faker::Quote.famous_last_words, nil ].sample,
    product: products.sample,
    user: users.sample
  )
end

puts "🌱🌱🌱🌱🌱🌱🌱 SEEDING.... 🌱🌱🌱🌱🌱🌱🌱"
puts "✅✅✅✅✅✅✅ COMPLETED   ✅✅✅✅✅✅✅"
