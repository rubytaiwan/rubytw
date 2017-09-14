module Admin
  class BlogsController < Fae::BaseController

    def index
      @items = Blog.order('date_of_news DESC')
    end

    def new
      super
      @item.date_of_news = Time.zone.now
    end

    private

    def build_assets
      @item.build_cover_image if @item.cover_image.blank?
    end
  end
end
