class RecipesController < ApplicationController
  before_action :authenticate_user!, only: %i[new destroy create]
  load_and_authorize_resource

  def index
    @recipes = Recipe.includes(:user).all
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe_foods = @recipe.recipe_foods.includes(:food)
  end

  def new
    @recipe = Recipe.new
  end

  def public
    @recipes = Recipe.where(public: true).order(created_at: :desc)
  end

  def toggle_public
    @recipe = Recipe.find(params[:id])
    @recipe.update(public: !@recipe.public)
    redirect_to recipe_path, notice: 'successfully updated'
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
