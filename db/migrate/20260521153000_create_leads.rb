class CreateLeads < ActiveRecord::Migration[8.0]
  def change
    create_table :leads do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.integer :service_type
      t.text :message
      t.integer :status
      t.text :notes
      t.string :source

      t.timestamps
    end
  end
end
