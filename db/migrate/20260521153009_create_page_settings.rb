class CreatePageSettings < ActiveRecord::Migration[8.0]
  def change
    create_table :page_settings do |t|
      t.string :key
      t.jsonb :value

      t.timestamps
    end
  end
end
