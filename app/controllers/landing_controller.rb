class LandingController < ApplicationController
  def show
    events = Event.upcoming.limit(3)
    render "landing/show", locals: { events: events }
  end
end
