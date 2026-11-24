class PageSetting < ApplicationRecord
  has_one_attached :hero_image
  has_one_attached :section_image
  has_one_attached :og_image
  has_rich_text :rich_content

  validates :key, presence: true, uniqueness: true
  validates :page_name, presence: true

  before_validation :sync_slug_and_name

  def self.for(page_key)
    find_by(key: page_key.to_s)
  end

  def setting(attr_key, default = nil)
    (settings || {})[attr_key.to_s].presence || default
  end

  private

  def sync_slug_and_name
    self.slug = key.to_s.parameterize if slug.blank? && key.present?
    self.page_name = key.to_s.humanize if page_name.blank? && key.present?
  end
end
