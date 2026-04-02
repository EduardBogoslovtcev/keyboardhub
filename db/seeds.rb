require 'faker'

# PROVINCES & TERRITORIES
Province.destroy_all

provinces = [
  { name: "Alberta", tax_rate: 0.05 },
  { name: "British Columbia", tax_rate: 0.12 },
  { name: "Manitoba", tax_rate: 0.12 },
  { name: "New Brunswick", tax_rate: 0.15 },
  { name: "Newfoundland and Labrador", tax_rate: 0.15 },
  { name: "Nova Scotia", tax_rate: 0.14 },
  { name: "Ontario", tax_rate: 0.13 },
  { name: "Prince Edward Island", tax_rate: 0.15 },
  { name: "Quebec", tax_rate: 0.14975 },
  { name: "Saskatchewan", tax_rate: 0.11 },
  { name: "Northwest Territories", tax_rate: 0.05 },
  { name: "Nunavut", tax_rate: 0.05 },
  { name: "Yukon", tax_rate: 0.05 }
]

provinces.each { |p| Province.create!(p) }

# BRANDS
Brand.destroy_all

brands = [
  "Keychron", "Logitech", "Razer", "SteelSeries",
  "Corsair", "Ducky", "HyperX", "Anne Pro",
  "Royal Kludge", "Akko"
]

brands.each { |b| Brand.create!(name: b) }

# SWITCH TYPES
SwitchType.destroy_all

switches = [
  "Cherry MX Red",
  "Cherry MX Blue",
  "Cherry MX Brown",
  "Gateron Red",
  "Gateron Brown",
  "Gateron Blue",
  "Optical Red",
  "Optical Blue"
]

switches.each { |s| SwitchType.create!(name: s) }

# LAYOUTS
Layout.destroy_all

layouts = ["60%", "65%", "75%", "TKL", "Full-size"]

layouts.each { |l| Layout.create!(name: l) }

# PRODUCTS (100 KEYBOARDS)
Product.destroy_all

100.times do
  Product.create!(
    name: "#{Brand.all.sample.name} #{Faker::Device.model_name} Keyboard",
    description: Faker::Lorem.sentence(word_count: 12),
    price: rand(80..300),
    brand: Brand.all.sample,
    layout: Layout.all.sample,
    switch_type: SwitchType.all.sample,
    image: "https://m.media-amazon.com/images/I/61EwH7sOi5L.jpg"
  )
end

# ADMIN USER
User.find_or_create_by!(email: "admin@keyboardhub.com") do |user|
  user.password = "password"
  user.password_confirmation = "password"
  user.role = "admin"
end

puts "Seeded database successfully!"