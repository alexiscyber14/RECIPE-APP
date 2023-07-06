class FoodsController < ApplicationController
  before_action :authenticate_user!

  # GET /foods or /foods.json
  def index
    # @foods = Food.all
    @foods = Food.accessible_by(current_ability)
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

  # PATCH/PUT /foods/1 or /foods/1.json
  def update
    @food = Food.find(params[:id])
    Rails.logger.info("Current food is #{@current_food}")
    if @food.update(food_params)
      redirect_to foods_path
    else
      render :edit
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
    params.require(:food).permit(:id, :name, :measurement_unit, :quantity, :price)
  end
end
