class CommentsController < ApplicationController
  before_action :find_comment, only: %i(show edit update destroy)
  before_action ->{authenticate_commentable comment.user}, only: %i(update destroy)

  def create
    @comment = Comment.new comment_params

    respond_to do |format|
      if not comment.save
        format.js {render "created_failed"}
      end
    end
  end

  def show; end

  def edit; end

  def update
    respond_to do |format|
      if not comment.update comment_params
        format.js {render "updated_failed"}
      end
    end
  end

  def destroy
    respond_to do |format|
      if not comment.destroy
        format.js {render "destroyed_failed"}
      end
    end
  end

  private

  attr_reader :comment

  def find_comment
    @comment = Comment.find_by id: params[:id]

    return if comment
    redirect_back fallback_location: root_path, alert: t("admin.resource.not_found")
  end

  def comment_params
    params.require(:comment).permit Comment::COMMENT_PARAMS
  end
end
