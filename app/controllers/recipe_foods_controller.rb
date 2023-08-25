class RecipeFoodsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  def new
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.new
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.find(params[:id])
    @recipe_food.destroy
    redirect_to recipe_path(@recipe), notice: 'successfully remove'
  end

  def edit
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.find(params[:id])
  end

  def update
    @recipe_food = RecipeFood.find(params[:id])

    if @recipe_food.update(recipe_food_params)
      flash[:notice] = 'Updated successfully'
      redirect_to recipe_path(@recipe_food.recipe)
    else
      flash[:notice] = 'Not Updated'
      render :edit
    end
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
