start = Time.now

require 'rest-client'
require 'nokogiri'
require 'csv'


def get_stuff_from_page(page,xpath)
	begin
	  request = RestClient::Resource.new(page, :verify_ssl => false).get
	rescue RestClient::NotFound => not_found
	  return not_found
	rescue 
	  return nil
	else
	  	payload = []
	  	Nokogiri::HTML(request).xpath(xpath).map{|item|
			payload << item.text.strip if item != nil
		}
		return payload
	end
end

def get_pairs_from_xpath(array)
	payload = []

	first = 0
	second = 1
	
	loop do 
		@arr = []
		#payload << [ array[first], array[second] ]
		@arr << array[first]
		@arr << array[second]
		payload << @arr
		first += 2
		second += 2
		break if array[first] == nil or array[second] == nil
	end

	return payload
end

url = "http://www.bigoven.com/recipes/vegan/best/page/"
xpath = "//div[@class='recipe-tile-full']//ul/li/p/a/@href | //div[@class='recipe-tile-full']//ul/li/p/a"

big_oven = CSV.open("/Users/Graphiq-NS/Desktop/vegan/big_oven.csv","a+")
1000.times do |i|
	results = get_stuff_from_page(url+i.to_s,xpath)
	get_pairs_from_xpath(results).each{|pair|
		big_oven << pair
	}

	puts "added #{get_pairs_from_xpath(results).count} rows in #{Time.now-start} seconds..."
	break if results.length == 0 and i > 50
end


big_oven.each{|recipe|
	p recipe
	puts
}

puts big_oven.class
puts big_oven.count
=begin
first = 0
second = 1

loop do 
	p results[first]
	p results[second]
	puts 
	first += 2
	second += 2

	break if results[first] == nil or results[second] == nil
end
=end


puts "Script took #{(Time.now-start)/60} minutes to run"




