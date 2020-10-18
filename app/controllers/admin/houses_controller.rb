class Admin::HousesController < ApplicationController
  before_action :admin_user
  before_action :set_categories

  def index
    @houses = SearchHousesForm.new(params).result
    @categories = Category.where(is_valid: true).shuffle.first(5)
    @house_areas = HouseArea.all
  end

  def show
    @house = House.find(params[:id])
    @categories = Category.where(is_valid: true).shuffle.first(5)
    @house_areas = HouseArea.all
  end

  def new
    @house = House.new
  end

def create
  @house = House.new(house_params)
  # category = Category.find(params[:category_id])
    if @house.save
      # @house.categories << @category
      flash[:success] = "ゲストハウスを作成しました"
      redirect_to admin_house_path(@house)
    else
      flash.now[:warning] = "ゲストハウスの作成に失敗しました"
      render action: :new
    end
end

def edit
  @house = House.find(params[:id])
end

def update
  @house = House.find(params[:id])
    if @house.update(house_params)
      flash[:success] = "ゲストハウスの情報を更新しました"
      redirect_to admin_house_url(@house)
    else
      flash.now[:warining] = "情報の更新に失敗しました"
      render action: :edit
    end
end

def destroy
  @house = House.find(params[:id])
  @house.destroy
  flash[:danger] = "ゲストハウスを削除しました"
  redirect_to admin_houses_path
end


  private

  def house_params
    params.require(:house).permit(:name, :postcode, :prefecture_code, :address, :domitory_price, :private_price,
                                  :copy, :introduction, :house_image, :is_valid, {:category_ids => []}, {images: []}, :house_area_id)
  end

  def set_categories
    @categories = Category.where(is_valid: true)
  end

    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end