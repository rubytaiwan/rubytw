class HomeController < ApplicationController
  def landing
    @blogs = Blog.where(active: true).order('date_of_news DESC')
    @events = Event.order('start_on DESC')
    @events_active = Event.where(active: true)
    @events_ended = Event.where(active: false)
    @communities = Community.all
  end
end
