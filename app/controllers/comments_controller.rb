class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.post_id = params[:post_id]
    @comment.save!
    redirect_to post_path(@comment.post)
  end

  def comment_params # only for when you create new things
    params.require(:comment).permit(:content)
  end
end
