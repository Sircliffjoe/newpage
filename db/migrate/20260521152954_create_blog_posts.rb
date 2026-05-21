class CreateBlogPosts < ActiveRecord::Migration[8.0]
  def change
    create_table :blog_posts do |t|
      t.string :title
      t.string :slug
      t.text :excerpt
      t.references :blog_category, null: false, foreign_key: true
      t.string :tags
      t.integer :status
      t.datetime :published_at
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.string :featured_image

      t.timestamps
    end
  end
end
