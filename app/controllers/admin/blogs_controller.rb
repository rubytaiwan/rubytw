module Admin
  class BlogsController < Fae::BaseController

    private

    def build_assets
      @item.build_cover_image if @item.cover_image.blank?
    end

  end
end
