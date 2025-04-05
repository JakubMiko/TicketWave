class LandingController < ApplicationController
  def show
    events = Event.where("date > ?", DateTime.now).order(date: :asc).limit(3)
    render "landing/show", locals: { events: events }
  end
end