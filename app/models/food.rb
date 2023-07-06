class Food < ApplicationRecord
  belongs_to :user
  has_many :food_recipes
  validates :name, presence: true
  validates :measurement_unit, presence: true
  validates :price, numericality: {}
  validates :quantity, numericality: { only_integer: true }
end
