class HomeController < ApplicationController
  def index
  	#@dishes = Dish.all
  	@dishes = Dish.search(params[:search])
  end
end
