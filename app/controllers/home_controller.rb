class HomeController < ApplicationController
  def landing
    @events = Event.order('date_of_event DESC')
  end
end
