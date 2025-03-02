class LandingController < ApplicationController
  def show
    render Landing::ShowComponent.new
  end
end
