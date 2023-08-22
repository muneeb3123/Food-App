class FoodsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  def index
    @foods = Food.all
  end

  def show
    @food = Food.find(params[:id])
  end

  def new
    @food = Food.new
  end

  def create
    @user = current_user
    @food = @user.foods.build(food_params)
    if @food.save
      flash[:notice] = 'Food  created'
      redirect_to foods_path
    else
      flash.now[:alert] = @food.errors.full_messages.join(', ')
      render :new
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    redirect_to foods_path
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
