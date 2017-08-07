module Admin
  class EventsController < Fae::BaseController

    def index
      @items = Event.order('start_on DESC')
    end

    private

    def build_assets
      @item.build_cover_image if @item.cover_image.blank?
    end

  end
end
