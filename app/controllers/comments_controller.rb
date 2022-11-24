class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :define_variables, only: %i[create]
  before_action :define_comment, except: %i[create]

  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user = @user

    if @comment.save
      redirect_to commentable_path(@comment), success: I18n.t('flash.new', model: comment_model_name.downcase)
    else
      redirect_to commentable_path(@comment), danger: "#{@comment.errors.full_messages.each{|error| error.capitalize}.join(' ')}"
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to commentable_path(@comment), success: I18n.t('flash.update', model: comment_model_name.downcase)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @comment.destroy
      redirect_to commentable_path(@comment), success: 'DELETED@'#I18n.t('flash.destroy', model: comment_model_name.downcase)
    end
  end

  private

    def define_variables
      @user = User.find_by(id: current_user.id)
      
      # set commentable
      resource, id = request.path.split('/')[1, 2]  
      @commentable = resource.singularize.classify.constantize.find(id)
    end

    def define_comment
      @comment = Comment.find(params[:id])
    end

    def commentable_path(comment)
      "/#{comment.commentable_type.downcase.pluralize}/#{comment.commentable_id}"
    end
    
    def comment_params
      params.require(:comment).permit(:body, :status)
    end
end
