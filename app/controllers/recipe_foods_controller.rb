class RecipeFoodsController < ApplicationController
  def new
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.new
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.new(recipe_food_params)

    if @recipe_food.save
      flash[:notice] = 'Recipe food created successfully'
      redirect_to recipe_path(@recipe)
    else
      flash[:notice] = 'Not created'
      render :new
    end
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :food_id, :recipe_id)
  end
end
