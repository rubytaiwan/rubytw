module Admin
  class BlogsController < Fae::BaseController

    def index
      @items = Blog.order('date_of_news DESC')
    end

    private

    def build_assets
      @item.build_cover_image if @item.cover_image.blank?
    end

  end
end
