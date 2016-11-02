start = Time.now

require 'rest-client'
require 'nokogiri'
require 'csv'


def get_stuff_from_page(page,xpath)
	begin
	  request = RestClient::Resource.new(page, :verify_ssl => false).get
	rescue RestClient::NotFound => not_found
	  return nil
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

url = "http://www.findingvegan.com/page/"
xpath = "//div[@class='site-content']//div[@class='photo']/@onclick | //div[@class='postInfo']//div/h1"

#p get_stuff_from_page(url,xpath)

finding_vegan = CSV.open("/Users/Graphiq-NS/Desktop/vegan/finding_vegan.csv","a+")
10000.times do |i|
	results = get_stuff_from_page(url+i.to_s,xpath)
	get_pairs_from_xpath(results).each{|pair|
		finding_vegan << [ pair[0][14..-3], pair[1] ]
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
=end


puts "Script took #{(Time.now-start)/60} minutes to run"




