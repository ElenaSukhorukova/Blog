class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :comment_model_name
  helper_method :article_model_name

  add_flash_types :info, :danger, :warning, :success, :alert, :notice

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  def comment_model_name
    Comment.model_name.human
  end
  
  def article_model_name
    Article.model_name.human
  end
end
