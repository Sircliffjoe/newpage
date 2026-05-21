class CreateDestinations < ActiveRecord::Migration[8.0]
  def change
    create_table :destinations do |t|
      t.string :name
      t.string :slug
      t.string :country_code
      t.text :description
      t.string :hero_image
      t.text :requirements
      t.string :cost_estimate
      t.integer :category
      t.integer :position
      t.boolean :published

      t.timestamps
    end
  end
end
