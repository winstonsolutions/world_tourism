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

# 预定义主要国家的城市
city_data = {
  'United States' => {
    capital: 'Washington D.C.',
    cities: ['New York', 'Los Angeles', 'Chicago', 'Houston', 'Phoenix', 'Philadelphia', 'San Antonio', 'San Diego', 'Dallas', 'Boston']
  },
  'Canada' => {
    capital: 'Ottawa',
    cities: ['Toronto', 'Montreal', 'Vancouver', 'Calgary', 'Edmonton', 'Quebec City', 'Winnipeg', 'Halifax', 'Saskatoon']
  },
  'Mexico' => {
    capital: 'Mexico City',
    cities: ['Guadalajara', 'Monterrey', 'Puebla', 'Tijuana', 'Cancún', 'Mérida', 'León', 'Querétaro']
  },
  'United Kingdom' => {
    capital: 'London',
    cities: ['Manchester', 'Birmingham', 'Glasgow', 'Liverpool', 'Edinburgh', 'Bristol', 'Leeds', 'Sheffield', 'Newcastle', 'Belfast']
  },
  'France' => {
    capital: 'Paris',
    cities: ['Marseille', 'Lyon', 'Toulouse', 'Nice', 'Nantes', 'Strasbourg', 'Bordeaux', 'Lille', 'Rennes', 'Reims']
  },
  'Germany' => {
    capital: 'Berlin',
    cities: ['Munich', 'Hamburg', 'Frankfurt', 'Cologne', 'Stuttgart', 'Dusseldorf', 'Leipzig', 'Dresden', 'Hanover', 'Nuremberg']
  },
  'Italy' => {
    capital: 'Rome',
    cities: ['Milan', 'Naples', 'Turin', 'Florence', 'Bologna', 'Venice', 'Verona', 'Genoa', 'Palermo', 'Bari']
  },
  'Spain' => {
    capital: 'Madrid',
    cities: ['Barcelona', 'Valencia', 'Seville', 'Zaragoza', 'Málaga', 'Bilbao', 'Alicante', 'Granada', 'Palma', 'Las Palmas']
  },
  'China' => {
    capital: 'Beijing',
    cities: ['Shanghai', 'Guangzhou', 'Shenzhen', 'Chengdu', 'Hangzhou', 'Xi\'an', 'Nanjing', 'Wuhan', 'Chongqing', 'Tianjin']
  },
  'Japan' => {
    capital: 'Tokyo',
    cities: ['Osaka', 'Kyoto', 'Yokohama', 'Nagoya', 'Sapporo', 'Fukuoka', 'Kobe', 'Hiroshima', 'Sendai', 'Kawasaki']
  },
  'India' => {
    capital: 'New Delhi',
    cities: ['Mumbai', 'Bangalore', 'Kolkata', 'Chennai', 'Hyderabad', 'Pune', 'Ahmedabad', 'Jaipur', 'Lucknow', 'Kanpur']
  },
  'Australia' => {
    capital: 'Canberra',
    cities: ['Sydney', 'Melbourne', 'Brisbane', 'Perth', 'Adelaide', 'Gold Coast', 'Newcastle', 'Canberra', 'Wollongong', 'Hobart']
  },
  'Brazil' => {
    capital: 'Brasília',
    cities: ['São Paulo', 'Rio de Janeiro', 'Salvador', 'Fortaleza', 'Belo Horizonte', 'Manaus', 'Curitiba', 'Recife', 'Porto Alegre']
  },
  'Argentina' => {
    capital: 'Buenos Aires',
    cities: ['Córdoba', 'Rosario', 'Mendoza', 'San Miguel de Tucumán', 'La Plata', 'Mar del Plata', 'Salta', 'Santa Fe']
  },
  'Egypt' => {
    capital: 'Cairo',
    cities: ['Alexandria', 'Giza', 'Shubra El-Kheima', 'Port Said', 'Suez', 'Luxor', 'Aswan', 'Hurghada']
  },
  'South Africa' => {
    capital: 'Pretoria',
    cities: ['Johannesburg', 'Cape Town', 'Durban', 'Soweto', 'Port Elizabeth', 'Pietermaritzburg', 'Benoni', 'Bloemfontein']
  }
}

# 国家到Faker语言环境的映射
locale_map = {
  'France' => 'fr',
  'Germany' => 'de',
  'Spain' => 'es',
  'Italy' => 'it',
  'Japan' => 'ja',
  'China' => 'zh-CN',
  'Brazil' => 'pt-BR'
}

puts "Creating cities..."
countries = Country.all
countries.each do |country|
  if city_data.key?(country.name)
    # 使用预定义城市数据
    # 创建首都
    City.create!(
      name: city_data[country.name][:capital],
      is_capital: true,
      population: rand(1_000_000..20_000_000),
      country: country
    )
    
    # 创建随机数量的其他城市（3-7个）
    city_data[country.name][:cities].sample(rand(3..7)).each do |city_name|
      City.create!(
        name: city_name,
        is_capital: false,
        population: rand(100_000..8_000_000),
        country: country
      )
    end
  else
    # 对于没有预定义城市的国家，使用Faker（尽可能使用本地化）
    locale = locale_map[country.name] || 'en'
    
    # 创建首都（对于没有预定义数据的国家）
    capital_name = "Capital of #{country.name}"
    if locale == 'en'
      capital_name = Faker::Address.unique.city
    else
      begin
        capital_name = Faker::Address.unique.city(locale: locale)
      rescue
        capital_name = Faker::Address.unique.city # 回退到英语
      end
    end
    
    City.create!(
      name: capital_name,
      is_capital: true,
      population: rand(500_000..10_000_000),
      country: country
    )
    
    # 创建其他城市（2-5个）
    rand(2..5).times do
      city_name = if locale == 'en'
                    Faker::Address.unique.city
                  else
                    begin
                      Faker::Address.unique.city(locale: locale)
                    rescue
                      Faker::Address.unique.city # 回退到英语
                    end
                  end
      
      City.create!(
        name: city_name,
        is_capital: false,
        population: rand(50_000..3_000_000),
        country: country
      )
    end
  end
end

puts "Created #{City.count} cities"

puts "Creating attractions..."
cities = City.all
cities.each do |city|
  # 生成更符合地点特色的景点名称
  attraction_types = ['Museum', 'Park', 'Monument', 'Cathedral', 'Castle', 'Palace', 'Square', 'Tower', 'Bridge', 'Garden']
  
  # 为每个城市创建2-6个景点
  num_attractions = rand(2..6)
  num_attractions.times do
    attraction_type = attraction_types.sample
    
    # 生成更真实的名称
    name = if ['Museum', 'Park', 'Cathedral', 'Castle'].include?(attraction_type)
             "#{city.name} #{attraction_type}"
           else
             "#{Faker::Adjective.positive} #{attraction_type} of #{city.name}"
           end
    
    Attraction.create!(
      name: name,
      description: Faker::Lorem.paragraph(sentence_count: 3, supplemental: true),
      rating: rand(1.0..5.0).round(1),
      entrance_fee: rand(0..50.0).round(2),
      city: city
    )
  end
end

puts "Created #{Attraction.count} attractions"

puts "Seeding completed!"