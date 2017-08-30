class BlogsController < ApplicationController

  def show
    @blog = Blog.find(params[:id])
  end

end
