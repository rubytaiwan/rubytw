class HomeController < ApplicationController
  def landing
    @events = Event.order('start_date DESC')
  end
end
