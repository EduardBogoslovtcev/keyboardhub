# db/seeds.rb

Province.create([
  { name: "Ontario", tax_rate: 0.13 },
  { name: "Alberta", tax_rate: 0.05 },
  { name: "British Columbia", tax_rate: 0.12 },
  { name: "Manitoba", tax_rate: 0.12 },
  { name: "Quebec", tax_rate: 0.14975 }
])