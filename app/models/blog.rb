class Blog < ApplicationRecord
  include Fae::BaseModelConcern

  def fae_display_field
    title
  end

  has_fae_image :cover_image


end
