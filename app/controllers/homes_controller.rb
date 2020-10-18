class HomesController < ApplicationController
  def top
    @categories = Category.where(is_valid: true).shuffle.first(5)
    @house_areas = HouseArea.all
    @houses = House.all.shuffle
    @stories = Story.all.shuffle.first(2)
    @tweets = Tweet.all.shuffle.first(2)
  end

  def about
  end

  def term
  end
  
  def privacy
  end
end
