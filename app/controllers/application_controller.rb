# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  include ErrorHandling
  include ApplicationHelper
  include MostArticles
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :define_articles!

  add_flash_types :info, :danger, :warning, :success, :alert, :notice

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  def define_articles!
    return articles_for_signed_user if user_signed_in?

    @main_pagy, @articles = pagy Article.archived, items: 4, page_param: :main_pagy
    @articles = @articles.decorate
  end

  def articles_for_signed_user
    @main_pagy, @articles = pagy Article.pablic_private, items: 4, page_param: :main_pagy
    @comentered_articles = most_commented(@articles)
    @comentered_articles = @comentered_articles.map(&:decorate)
    @articles = @articles.decorate

    @sidebar_pagy, @archived_articles = pagy Article.pablic, items: 4, page_param: :sidebar_pagy
    @archived_articles = @archived_articles.decorate
  end
end
