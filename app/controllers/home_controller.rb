class HomeController < ApplicationController
  def landing
    @events = Event.order('start_on DESC')
    @communities = Community.all
  end
end
