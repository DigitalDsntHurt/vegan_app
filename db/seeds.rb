# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'
csv = CSV.open(Rails.root.join('lib','seeds','big_oven.csv'))

payload = []
csv.to_a.each{|row|
	@hsh = {}
	@hsh[:name] = row[0]
	@hsh[:url] = row[1]

	Dish.create!(@hsh)
}