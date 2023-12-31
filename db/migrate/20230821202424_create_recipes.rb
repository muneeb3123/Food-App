class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, limit: 200
      t.integer :preparation_time
      t.integer :cooking_time
      t.text :description
      t.boolean :public

      t.timestamps
    end
  end
end
