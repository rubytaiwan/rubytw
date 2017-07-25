module Admin
  class EventsController < Fae::BaseController

    private

    def build_assets
      @item.build_cover_image if @item.cover_image.blank?
    end

  end
end
