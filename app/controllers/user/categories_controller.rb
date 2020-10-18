class User::CategoriesController < ApplicationController
  def index
    @categories_all = Category.where(is_valid: true)
    @categories = Category.where(is_valid: true).shuffle.first(5)
    @house_areas = HouseArea.all
  end
end