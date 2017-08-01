module Admin
  class CommunitiesController < Fae::BaseController

    def index
      @items = Community.order('id')
    end

  end
end
