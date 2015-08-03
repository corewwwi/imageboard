class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :resource_params

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
      devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
    end

    def render_404
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end

    def render_500
      render file: "#{Rails.root}/public/500.html", layout: false, status: 500
    end

    rescue_from CanCan::AccessDenied do |exception|
      render_500
    end
    
    def resource_params
      resource = controller_name.singularize.to_sym
      method = "#{resource}_params"
      params[resource] &&= send(method) if respond_to?(method, true)
    end  

end