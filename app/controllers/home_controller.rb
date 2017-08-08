class HomeController < ApplicationController
  def landing
    @blogs = Blog.order('date_of_news DESC')
    @events = Event.order('start_on DESC')
    @communities = Community.all
  end
end
