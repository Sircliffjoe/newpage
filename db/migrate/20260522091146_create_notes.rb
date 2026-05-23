class CreateNotes < ActiveRecord::Migration[8.0]
  def change
    create_table :notes do |t|
      t.text :body

      t.references :author,
                   null: false,
                   foreign_key: { to_table: :users }

      t.references :notetable,
                   polymorphic: true,
                   null: false

      t.timestamps
    end
  end
end