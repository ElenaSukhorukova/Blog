# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :define_user!, only: %i[new create]
  before_action :define_article!, except: %i[new create index]

  def index; end

  def show
    @article = @article.decorate
    @comment = @article.comments.build

    if user_signed_in?
      @pagy, @comments = pagy @article.comments.pablic_private, items: 5
    else
      @pagy, @comments = pagy @article.comments.pablic, items: 5
    end
    @comments = @comments.map(&:decorate)
  end

  def new
    @article = @user.articles.build
  end

  def edit; end

  def create
    @article = @user.articles.build(article_params)

    if @article.save
      redirect_to article_path(@article),
                  success: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @article.update(article_params)
      redirect_to article_path(@article),
                  success: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    return unless @article.destroy

    redirect_to articles_path,
                success: t('.success')
  end

  private

  def define_user!
    @user = User.find(params[:user_id]) if user_signed_in?
  end

  def define_article!
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :content, :status)
  end
end
