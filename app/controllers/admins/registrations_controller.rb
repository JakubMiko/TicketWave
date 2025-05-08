class Admins::RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_admin_credentials, only: [ :new, :create ]
  before_action :configure_sign_up_params, only: [ :create ]
  skip_before_action :require_no_authentication, only: [ :new, :create ]

  def new
    super
  end

  def create
    if params[:admin]
      params[:admin][:role] = "admin"
    end
    super
  end

  protected

  def authenticate_admin_credentials
    authenticate_or_request_with_http_basic("Admin Sign Up") do |username, password|
      username == Rails.application.credentials.dig(:admin, :username) &&
      password == Rails.application.credentials.dig(:admin, :password)
    end
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :first_name, :last_name, :role ])
  end

  def after_sign_up_path_for(resource)
    admins_dashboard_path
  end
end
