class CreateUser < ActiveRecord::Migration[7.0]
  def change
=begin
    create_table :users do |t|
      t.string :name, null: false

      t.timestamps
    end
=end
  end
end
