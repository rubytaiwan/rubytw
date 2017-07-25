class Event < ApplicationRecord
  include Fae::BaseModelConcern

  validates :apply_link, Fae.validation_helpers.url

  def fae_display_field
    title
  end

  has_fae_image :cover_image


end
