class RecipesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe, only: %i[show edit update destroy]

  # GET /recipes or /recipes.json
  def index
    @recipes = Recipe.where(user_id: current_user.id)
  end

  # GET /recipes/1 or /recipes/1.json
  def show
    @foods = Food.joins(:food_recipes).where(food_recipes: { recipe_id: params[:id] }).where(user_id: current_user.id)
  rescue ActiveRecord::RecordNotFound
    # Catch the error if the record is not found and return an empty array
    @foods = []
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit; end

  # POST /recipes or /recipes.json
  def create
    @create_recipe = recipe_params.merge(user_id: current_user.id)
    # @modify_public = params[:recipe][:public] = recipe_params[:public].to_i.zero? ? false : true
    @recipe = Recipe.new(recipe_params.merge(user_id: current_user.id))
    @recipe[:public] = @recipe[:public] != '0'
    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipes_path, notice: 'Recipe was successfully created.' }
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

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def recipe_params
    params.require(:recipe).permit(:name, :description, :preparation_time, :cooking_time, :public)
  end
end
