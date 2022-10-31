require 'httparty'
require 'nokogiri'
require 'pp'

def convertPrice(price)
  price.gsub('$','').gsub(',','').to_i
end
def carShoper
  response = HTTParty.get('https://code.evgenyrahman.com/rubycourse/carlist.html')
  prasedHtml = Nokogiri::HTML(response.body)
  carListing = prasedHtml.css('.card.car')

  puts "hello"
  cars = carListing.map do |car|
    {
      make: car.css('.make').text,
      year: car.css('.year').text.to_i,
      price: convertPrice(car.css('.price').text),
      star: car.css('.star').attribute("data-rating").value.to_i
    }
  end
  cars.select! do |car|
    car[:price] < 30000
  end

  File.open("carListing.json","wb") do |f|
    f << cars.to_json
  end
end

carShoper
