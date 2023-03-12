module Admin
  class BlogsController < Fae::BaseController
    before_action :form_url, only: %i[new edit]

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

    def form_url
      @form_url = action_name == 'new' ? admin_blogs_path : admin_blog_path(@item.id)
    end
  end
end
