class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  enum :role, { staff: 0, content_editor: 1, super_admin: 2 }, default: :staff

  has_many :blog_posts, foreign_key: :author_id, dependent: :nullify
  has_many :sent_emails, class_name: "Email", foreign_key: :sent_by_id, dependent: :nullify
  has_many :notes, foreign_key: :author_id, dependent: :destroy
  has_many :assigned_leads, class_name: "Lead", foreign_key: :assigned_to_id, dependent: :nullify

  def full_name
    [first_name, last_name].compact_blank.join(" ").presence || email
  end
end
