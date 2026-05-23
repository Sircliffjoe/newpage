class CreatePlans < ActiveRecord::Migration[7.1]
  def change
    create_table :plans do |t|
      t.string :name, null: false
      t.text :description
      t.decimal :price, precision: 10, scale: 2, null: false
      t.string :stripe_price_id

      t.timestamps
    end

    add_index :plans, :name, unique: true
  end
end
