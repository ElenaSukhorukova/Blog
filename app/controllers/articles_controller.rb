class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :define_user, only: %i[new create]
  before_action :define_article, except: %i[new create index]

  def index
    if user_signed_in?
      @articles = Article.where.not(status: Article::VALID_STATUES[2]).order(created_at: :desc) 
    else
      @articles = Article.where(status: Article::VALID_STATUES[0]).order(created_at: :desc)
    end
    @archaved_articles = Article.where(status: Article::VALID_STATUES[1]).order(created_at: :desc)
  end

  def show
    @comment = @article.comments.build

    if user_signed_in?
      @comments = @article.comments.where.not(status: Article::VALID_STATUES[2]).order(created_at: :asc) 
    else
      @comments = @article.comments.where(status: Article::VALID_STATUES[0]).order(created_at: :desc)
    end
  end

  def new
    @article = @user.articles.build
  end

  def create
    @article = @user.articles.build(article_params)

    if @article.save
      redirect_to articles_path, 
        success: I18n.t('flash.new', model: article_model_name.downcase)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to article_path(@article), 
        success: I18n.t('flash.update', model: article_model_name.downcase)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @article.destroy
      redirect_to articles_path, 
        success: I18n.t('flash.destroy', model: article_model_name.downcase)
    end
  end

  private

    def define_user
      @user = User.find(params[:user_id]) if user_signed_in?
    end

    def define_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :content, :status)
    end
end