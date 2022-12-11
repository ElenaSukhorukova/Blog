class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :define_user!, only: %i[new create]
  before_action :define_article!, except: %i[new create index]

  def index
    if user_signed_in?
      @pagy, @articles = pagy Article.where.not(status: Article::VALID_STATUES[2]).order(created_at: :desc), items: 5
    else
      @pagy, @articles = pagy Article.where(status: Article::VALID_STATUES[0]).order(created_at: :desc), items: 5
    end
  end

  def show
    @comment = @article.comments.build

    if user_signed_in?
      @pagy, @comments = pagy @article.comments.where.not(status: Article::VALID_STATUES[2]).order(created_at: :asc), items: 5
    else
      @pagy, @comments = pagy @article.comments.where(status: Article::VALID_STATUES[0]).order(created_at: :desc), items: 5
    end
  end

  def new
    @article = @user.articles.build
  end

  def create
    @article = @user.articles.build(article_params)

    if @article.save
      redirect_to articles_path, 
        success: I18n.t('flash.new', model: i18n_model_name(@article).downcase)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to article_path(@article), 
        success: I18n.t('flash.update', model: i18n_model_name(@article).downcase)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @article.destroy
      redirect_to articles_path, 
        success: I18n.t('flash.destroy', model: i18n_model_name(@article).downcase)
    end
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