class AlignCmsSchemaAndAddEmails < ActiveRecord::Migration[8.0]
  def change
    # 1. Upgrade page_settings for full CMS page & media management
    change_table :page_settings, bulk: true do |t|
      t.string :page_name
      t.string :slug
      t.string :hero_title
      t.text :hero_subtitle
      t.string :meta_title
      t.text :meta_description
      t.text :content
      t.jsonb :settings, default: {}, null: false
    end
    add_index :page_settings, :key, unique: true
    add_index :page_settings, :slug, unique: true

    # 2. Align services
    change_table :services, bulk: true do |t|
      t.text :short_description
      t.string :icon
      t.boolean :featured, default: false, null: false
    end
    add_index :services, :slug, unique: true

    # 3. Align destinations
    change_table :destinations, bulk: true do |t|
      t.text :short_description
      t.boolean :visa_required, default: true, null: false
      t.boolean :featured, default: false, null: false
    end
    add_index :destinations, :slug, unique: true

    # 4. Align blog_posts
    change_table :blog_posts, bulk: true do |t|
      t.string :meta_title
      t.text :meta_description
      t.boolean :featured, default: false, null: false
    end
    add_index :blog_posts, :slug, unique: true

    # 5. Align team_members
    change_table :team_members, bulk: true do |t|
      t.string :email
      t.string :phone
      t.string :linkedin
      t.string :twitter
      t.string :facebook
    end

    # 6. Align leads (assigned staff user)
    add_reference :leads, :assigned_to, foreign_key: { to_table: :users }, null: true

    # 7. Add emails table for WaffiHub-style Admin Email Center + Brevo delivery logs
    create_table :emails do |t|
      t.string :recipient_email, null: false
      t.string :recipient_name
      t.string :subject, null: false
      t.text :body, null: false
      t.string :contact_type, default: "manual", null: false
      t.string :status, default: "pending", null: false
      t.text :error_message
      t.string :provider_message_id
      t.references :sent_by, foreign_key: { to_table: :users }, null: true
      t.datetime :sent_at

      t.timestamps
    end
    add_index :emails, :recipient_email
    add_index :emails, :status
    add_index :emails, :contact_type

    # 8. Add unique index on newsletter_subscribers email
    add_index :newsletter_subscribers, :email, unique: true
  end
end
