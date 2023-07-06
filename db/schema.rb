ActiveRecord::Schema[7.0].define(version: 20_230_627_193_017) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'food_recipes', force: :cascade do |t|
    t.bigint 'recipe_id', null: false
    t.bigint 'food_id', null: false
    t.decimal 'quantity'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['food_id'], name: 'index_food_recipes_on_food_id'
    t.index ['recipe_id'], name: 'index_food_recipes_on_recipe_id'
  end

  create_table 'foods', force: :cascade do |t|
    t.string 'name'
    t.string 'measurement_unit'
    t.integer 'price'
    t.integer 'quantity'
    t.bigint 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_foods_on_user_id'
  end

  create_table 'recipes', force: :cascade do |t|
    t.string 'name'
    t.text 'description'
    t.integer 'preparation_time'
    t.integer 'cooking_time'
    t.boolean 'public'
    t.bigint 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_recipes_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'food_recipes', 'foods'
  add_foreign_key 'food_recipes', 'recipes'
  add_foreign_key 'foods', 'users'
  add_foreign_key 'recipes', 'users'
end
