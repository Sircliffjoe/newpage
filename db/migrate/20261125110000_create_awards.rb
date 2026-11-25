class CreateAwards < ActiveRecord::Migration[8.1]
  def change
    create_table :awards do |t|
      t.string :title, null: false
      t.integer :recipient_type, default: 0, null: false
      t.string :recipient_name, null: false
      t.string :issuing_organization, null: false
      t.date :awarded_on
      t.string :location
      t.string :category
      t.text :description
      t.boolean :featured, default: false, null: false
      t.boolean :published, default: true, null: false
      t.integer :position, default: 0, null: false

      t.timestamps
    end

    add_index :awards, :recipient_type
    add_index :awards, :published
    add_index :awards, :featured
  end
end
