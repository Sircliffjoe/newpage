class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { staff: 0, content_editor: 1, super_admin: 2 }, default: :staff

  has_many :blog_posts, foreign_key: :author_id, dependent: :nullify
end
