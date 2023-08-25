class ShoppingListsController < ApplicationController
  def index
    @foods = current_user.foods
    @remaining_foods = Hash.new(0)
    @needed_foods = {}

    current_user.recipes.each do |recipe|
      recipe.recipe_foods.includes(:food).each do |recipe_food|
        food = recipe_food.food
        @remaining_foods[food] += recipe_food.quantity
      end
    end

    @remaining_foods.each do |food, remaining_quantity|
      if @foods.include?(food)
        needed_quantity = [remaining_quantity - food.quantity, 0].max
        @needed_foods[food] = needed_quantity if needed_quantity.positive?
      else
        @needed_foods[food] = remaining_quantity
      end
    end
    @total_amount = calculate_total_amount
  end

  private

  def calculate_total_amount
    total_amount = 0
    @needed_foods.each do |food, quantity|
      total_amount += food.price * quantity
    end
    total_amount.to_i
  end
end
