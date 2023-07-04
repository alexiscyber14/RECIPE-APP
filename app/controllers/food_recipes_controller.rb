class FoodRecipesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_food_recipe

  # GET /food_recipes or /food_recipes.json
  def index
    @foods = Food.joins(:food_recipes).where(user_id: current_user.id)
    @food_count = @foods.length
    @food_cost = @foods.sum(:price)
  end

  # GET /food_recipes/1 or /food_recipes/1.json
  def show; end

  # GET /food_recipes/new
  def new
    @food_recipe = FoodRecipe.new
  end

  # GET /food_recipes/1/edit
  def edit; end

  # POST /food_recipes or /food_recipes.json
  def create
    @food = Food.find_by(name: params[:category])
    @food_id = @food.id
    @food_recipe = FoodRecipe.new(recipe_id: params[:id], food_id: @food_id,
                                  quantity: food_recipe_params[:quantity].to_i)

    if @food_recipe.save
      redirect_to recipe_path
    else
      render :new
    end
  end

  # PATCH/PUT /food_recipes/1 or /food_recipes/1.json
  def update
    respond_to do |format|
      if @food_recipe.update(food_recipe_params)
        format.html { redirect_to food_recipe_url(@food_recipe), notice: 'Food recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @food_recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @food_recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /food_recipes/1 or /food_recipes/1.json
  def destroy
    @food_recipe.destroy

    respond_to do |format|
      format.html { redirect_to food_recipes_url, notice: 'Food recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_food_recipe
    @food_all = Food.where(user_id: current_user.id)
    # @food_recipe = FoodRecipe.find(params[:id])
    # @foods = Food.where(user_id: current_user.id)
  end

  private

  # Only allow a list of trusted parameters through.
  def food_recipe_params
    params.require(:food_recipe).permit(:category, :quantity)
  end
end
