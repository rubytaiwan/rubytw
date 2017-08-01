class Community < ApplicationRecord
  include Fae::BaseModelConcern

  validates :name, :link, :community_type, :active,  presence: true

  validates :link, Fae.validation_helpers.url

  def fae_display_field
    name
  end


end
