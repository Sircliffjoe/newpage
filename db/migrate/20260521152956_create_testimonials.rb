class CreateTestimonials < ActiveRecord::Migration[8.0]
  def change
    create_table :testimonials do |t|
      t.string :client_name
      t.text :content
      t.integer :rating
      t.string :photo
      t.integer :service_type
      t.boolean :published
      t.integer :position

      t.timestamps
    end
  end
end
