# frozen_string_literal: true

# Purpose: Controller for the Food model.
class FoodsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  def index
    @foods = Food.all
    # @food = Food.new
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
      redirect_to foods_path
    else
      @foods = Food.all
      render 'index'
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
