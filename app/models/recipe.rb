class Recipe < ApplicationRecord
  attr_accessor :public

  before_save :set_public

  belongs_to :user, foreign_key: :user_id
  belongs_to :user
  has_many :food_recipes, dependent: :destroy
  has_many :foods, through: :food_recipes
  accepts_nested_attributes_for :food_recipes
  # Validations
  validates :name, presence: true
  validates :preparation_time, presence: true
  validates :cooking_time, presence: true
  validates :description, presence: true
  
  def generate_shopping_list
    food_items = foods.where(user_id: user_id)

    # Return an array of food names
    food_items.pluck(:name)

  end

  private

  def set_public
    self.public ||= false
  end
end
