class FoodsController < ApplicationController
  before_action :authenticate_user!

  # GET /foods or /foods.json
  def index
    # @foods = Food.all
    @foods = Food.accessible_by(current_ability)
    @food_count = @foods.count
    @food_cost = @foods.sum(:price)
  end

  # GET /foods/1 or /foods/1.json
  def show; end

  # GET /foods/new
  def new
    @food = Food.new
  end

  # GET /foods/1/edit
  def edit
    @current_food = Food.find(params[:id])
  end

  # POST /foods or /foods.json
  def create
    @food = Food.new(food_params.merge(user_id: current_user.id))

    if @food.save
      redirect_to action: 'index'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /foods/1 or /foods/1.json
  def destroy
    @food = Food.find(params[:id])
    @food.destroy

    redirect_to root_path
  end

  private

  # Only allow a list of trusted parameters through.
  def food_params
    params.require(:food).permit(:id, :name, :measurement_unit, :price, :quantity)
  end
end
