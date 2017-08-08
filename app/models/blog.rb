class Blog < ApplicationRecord
  include Fae::BaseModelConcern

  validates :title, :date_of_news, :content, :active,  presence: true

  def fae_display_field
    title
  end

  has_fae_image :cover_image


end
