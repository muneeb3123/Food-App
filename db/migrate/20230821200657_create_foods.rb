class CreateFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :foods do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, limit: 200
      t.string :measurement_unit, limit: 50
      t.decimal :price
      t.integer :quantity

      t.timestamps
    end
  end
end
