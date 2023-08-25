class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |_exception|
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to request.referer || root_path
  end

  protect_from_forgery with: :exception

  before_action :update_allowed_parameters, if: :devise_controller?

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :name, :password, :role) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password) }
  end
end
