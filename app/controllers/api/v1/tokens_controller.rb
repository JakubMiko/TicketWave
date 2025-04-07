class Api::V1::TokensController < Api::V1::BaseController
  before_action :authenticate_user!  # Używa uwierzytelniania Devise (tylko dla zalogowanych użytkowników)

  def show
    render json: { api_token: current_user.api_token }
  end

  def create
    current_user.regenerate_api_token
    render json: { api_token: current_user.api_token }
  end
end
