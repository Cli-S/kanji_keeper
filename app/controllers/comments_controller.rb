class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.post_id = params[:post_id]
    @comment.save!
    redirect_to post_path(@comment.post)
  end

  def edit
    if current_user == Comment.find(params[:id]).user
      @comment = Comment.find(params[:id])
      @post = Post.find(params[:post_id])
    end
  end 

  def update
    if current_user == Comment.find(params[:id]).user
      @comment = Comment.find(params[:id])
      @comment.update!(comment_params)
      redirect_to post_path(@comment.post)
    end
  end

  def destroy
    if current_user == Comment.find(params[:id]).user
      @comment = Comment.find(params[:id])
      @comment.destroy!
      redirect_to post_path(@comment.post)
    end
  end

  def comment_params # only for when you create new things
    params.require(:comment).permit(:content)
  end
end
