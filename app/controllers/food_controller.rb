class FoodsController < ApplicationController
  before_action :authenticate_user!

  load_and_authorize_resource

  before_action :set_food, only: %i[show edit update destroy]

  # GET /foods or /foods.json
end
