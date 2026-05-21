class CreateServices < ActiveRecord::Migration[8.0]
  def change
    create_table :services do |t|
      t.string :title
      t.string :slug
      t.integer :category
      t.text :description
      t.string :hero_image
      t.text :benefits
      t.text :requirements
      t.jsonb :faq
      t.integer :position
      t.boolean :published

      t.timestamps
    end
  end
end
