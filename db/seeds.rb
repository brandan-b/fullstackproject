puts "Seeding…"

if Province.count == 0
  provinces = [
    ["Alberta", "AB", 0.05, 0.00, 0.00],
    ["British Columbia", "BC", 0.05, 0.07, 0.00],
    ["Manitoba", "MB", 0.05, 0.07, 0.00],
    ["Ontario", "ON", 0.00, 0.00, 0.13],
  ]
  provinces.each do |name, code, gst, pst, hst|
    Province.create!(name: name, code: code, gst_rate: gst, pst_rate: pst, hst_rate: hst)
  end
  puts "  Provinces seeded."
else
  puts "  Provinces exist (skipped)."
end

if Product.count < 10
  (1..12).each do |i|
    Product.create!(
      title: "Item #{i}",
      description: "A great product ##{i}",
      price_cents: [199, 299, 499, 999, 1499, 1999].sample
    )
  end
  puts "  Products seeded."
else
  puts "  Products exist (skipped)."
end

puts "Done."
