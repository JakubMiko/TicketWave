# frozen_string_literal: true

class Admins::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /admin/sign_in
  def new
    super
  end

  # POST /admin/sign_in
  def create
    super
  end

  # DELETE /admin/sign_out
  def destroy
    super
  end

  protected

  # Jeśli chcesz dodać dodatkowe parametry do logowania, odkomentuj poniższą metodę
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def after_sign_in_path_for(resource)
    admins_dashboard_path
  end
end
