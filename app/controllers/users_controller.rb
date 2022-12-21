# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @user_pagy, @user_articles = pagy @user.articles.order(created_at: :desc), items: 4, page_param: :user_pagy
    @user_articles = @user_articles.decorate
  end
end
