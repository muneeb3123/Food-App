class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show; end

  def new
    @recipe = Recipe.new
  end

  def create
    @user = current_user
    @recipe = @user.recipes.new(recipe_params)
    if @recipe.save
      flash[:notice] = 'Recipe created successfully'
      redirect_to recipes_path
    else
      flash[:notice] = 'Recipe not created'
      render :new
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
