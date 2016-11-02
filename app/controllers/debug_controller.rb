class DebugController < ApplicationController
  def index
  	@dishes = Dish.all
  end
end
