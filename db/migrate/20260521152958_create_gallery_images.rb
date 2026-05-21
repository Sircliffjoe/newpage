class CreateGalleryImages < ActiveRecord::Migration[8.0]
  def change
    create_table :gallery_images do |t|
      t.string :title
      t.text :caption
      t.integer :category
      t.integer :position
      t.boolean :published

      t.timestamps
    end
  end
end
