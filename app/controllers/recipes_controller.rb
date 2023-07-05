class RecipesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe, only: %i[show edit update destroy]

  # GET /recipes or /recipes.json
  def index
    @recipes = Recipe.where(user_id: current_user.id)
  end

  # GET /recipes/1 or /recipes/1.json
  def show
    begin
      @recipe = Recipe.find(params[:id])
      @foods = @recipe.foods
    rescue ActiveRecord::RecordNotFound
      # Catch the error if the record is not found and return an empty array
      @foods = []
    end
  end
  

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit; end

  # POST /recipes or /recipes.json
  def create
    @recipe = Recipe.new(recipe_params.merge(user_id: current_user.id))
    @recipe.public = (@recipe.public != '0')
  
    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipes_path, notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
        @recipe.food_recipes.where(quantity: nil).destroy_all
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to recipe_url(@recipe), notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to recipes_path, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def toggle_action
    @recipe = Recipe.find(params[:id])
    @toggle_status = @recipe[:public]
    @toggle_status = !@toggle_status
    @recipe[:public] = @toggle_status
    return unless @recipe.save

    redirect_to recipe_path
    # else
    #   render :show, notice: "An error occured"
  end

# recipes_controller.rb

# recipes_controller.rb

# recipes_controller.rb

def generate_shopping_list
  @recipe = Recipe.find(params[:id])
  @food_recipes = @recipe.food_recipes.includes(:food).where.not(quantity: nil) # Retrieve food_recipes with non-nil quantities and include associated food records
  @total_cost = @food_recipes.sum { |food_recipe| food_recipe.quantity.to_i * food_recipe.food.price.to_i }
  @item_count = @food_recipes.size
end



  
  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(
      :name, :description, :preparation_time, :cooking_time, :public,
      food_recipes_attributes: [:id, :food_id, :quantity,:food_ids, :_destroy]
    )
  end
  
  
  
end