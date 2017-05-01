class RecipesController < ApplicationController
  before_action :find_recipe, only: [:show, :edit, :update, :destroy]

  def index
    @recipes = Recipe.all
  end

  def show
  end

  def new
    @recipe = Recipe.new
    @recipe.directions.build
    @recipe.ingredients.build
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      flash[:notice] = "Create success!"
      redirect_to @recipe
    else
      flash[:alert] = "Create error"
      render :new
    end
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      flash[:notice] = "Update success!"
      redirect_to @recipe
    else
      flash[:alert] = "Update error"
      render :edit
    end
  end

  def destroy
    @recipe.destroy
    flash[:notice] = "Destroy success"
    redirect_to root_path
  end

  private 
    def find_recipe
      @recipe = Recipe.find(params[:id ])
    end

    def recipe_params
      params.require(:recipe).permit(:title, :description, :image,ingredients_attributes: [:id, :name, :_destroy], directions_attributes: [:id, :step, :_destroy] )
    end
end
