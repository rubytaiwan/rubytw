class Blog < ApplicationRecord
  include Fae::BaseModelConcern

  validates :title, :date_of_news, :content, :active,  presence: true
  validates :slug, presence: true, uniqueness: true

  has_fae_image :cover_image

  def fae_display_field
    title
  end

  def to_param
    slug
  end
end
