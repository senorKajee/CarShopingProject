require 'httparty'
require 'nokogiri'
def carShoper
  response = HTTParty.get('https://code.evgenyrahman.com/rubycourse/carlist.html')
  prasedHtml = Nokogiri::HTML(response.body)
  carListing = prasedHtml.css('.card.car')

  puts "hello"
  puts carListing.length
end

carShoper
