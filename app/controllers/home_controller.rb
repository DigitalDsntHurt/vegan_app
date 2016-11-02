class HomeController < ApplicationController

	def index
		@dishes = Dish.all
		@rand_dish = Dish.all.to_a[rand(Dish.all.length-1)]
	end
	
end
