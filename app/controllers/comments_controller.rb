# frozen_string_literal: true

class CommentsController < ApplicationController
  include ActionView::RecordIdentifier
  before_action :authenticate_user!
  before_action :define_user!, only: %i[create]
  before_action :define_comment!, except: %i[create]
  before_action :set_commentable!, only: %i[create]

  def edit; end

  def create
    @comment = @commentable.comments.build comment_params

    return redirect_to polymorphic_path(@comment.commentable_type, 
                                        @comment, anchor: dom_id(@comment)),
          success: t('.success') if @comment.save

    session[:comment_errors] = @comment.errors if @comment.errors.any?
    @pagy, @comments = pagy @commentable.comments.includes(:user).order(created_at: :desc), items: 3
    @commentable = @commentable.decorate
    @comments = @comments.decorate
    render("#{@commentable.object.class.to_s.pluralize.downcase}/show")
  end

  def update
    if @comment.update(comment_params)
      redirect_to commentable_path(@comment),
                  success: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    return unless @comment.destroy

    redirect_to commentable_path(@comment),
                success: t('.success')
  end

  private

  def define_user!
    @user = User.find_by id: current_user.id 
  end

  def set_commentable!
    klass = [Article].detect { |c| params["#{c.name.underscore}_id"] }
    # debugger
    raise ActiveRecord::RecordNotFound if klass.blank?

    @commentable = klass.find(params["#{klass.name.underscore}_id"])
  end

  def define_comment!
    @comment = Comment.find params[:id]
  end

  def comment_params
    params.require(:comment).permit(:body, :status).merge(user: current_user)
  end
end
