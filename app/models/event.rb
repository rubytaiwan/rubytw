class Event < ApplicationRecord
  include Fae::BaseModelConcern

  validates :title, :date_of_event, :location, :start_time, :end_time, :description,  presence: true

  validates :apply_link, Fae.validation_helpers.url

  def fae_display_field
    title
  end

  has_fae_image :cover_image


end
