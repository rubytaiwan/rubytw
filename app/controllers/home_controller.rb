class HomeController < ApplicationController
  def landing
    @events = Event.order('start_date DESC')
    @communities = Community.all
  end
end
