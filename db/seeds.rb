# db/seeds.rb
require 'csv'
require 'faker'

puts "Cleaning database..."
Attraction.destroy_all
City.destroy_all
Country.destroy_all

puts "Importing countries from CSV..."
csv_file = Rails.root.join('db', 'data', 'countries.csv')
CSV.foreach(csv_file, headers: true) do |row|
  Country.create!(
    name: row['name'],
    continent: row['continent'],
    currency: row['currency'],
    language: row['language']
  )
end

puts "Created #{Country.count} countries"

puts "Creating cities..."
countries = Country.all
countries.each do |country|
  # 为每个国家创建3-8个城市
  num_cities = rand(3..8)
  
  # 确保每个国家有一个首都城市
  city_name = Faker::Address.unique.city
  City.create!(
    name: city_name,
    is_capital: true,
    population: rand(100_000..10_000_000),
    country: country
  )
  
  # 创建其他非首都城市
  (num_cities - 1).times do
    city_name = Faker::Address.unique.city
    City.create!(
      name: city_name,
      is_capital: false,
      population: rand(10_000..5_000_000),
      country: country
    )
  end
end

puts "Created #{City.count} cities"

puts "Creating attractions..."
cities = City.all
cities.each do |city|
  # 为每个城市创建2-6个景点
  num_attractions = rand(2..6)
  num_attractions.times do
    Attraction.create!(
      name: "#{Faker::Adjective.positive} #{Faker::Ancient.god}",
      description: Faker::Lorem.paragraph(sentence_count: 3, supplemental: true),
      rating: rand(1.0..5.0).round(1),
      entrance_fee: rand(0..50.0).round(2),
      city: city
    )
  end
end

puts "Created #{Attraction.count} attractions"

puts "Seeding completed!"