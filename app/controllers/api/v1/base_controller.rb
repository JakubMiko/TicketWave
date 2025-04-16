# app/controllers/api/v1/base_controller.rb
class Api::V1::BaseController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_default_format

  protected

  def authenticate_api_user!
    @current_user = authenticate_with_api_token
    render json: { errors: [ { detail: "Unauthorized" } ] }, status: :unauthorized unless @current_user
  end

  def current_user
    @current_user
  end

  private

  def authenticate_with_api_token
    api_token = request.headers["X-API-Token"] || params[:api_token]
    User.find_by(api_token: api_token) if api_token.present?
  end

  def set_default_format
    request.format = :json
  end
end
