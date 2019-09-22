class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(user_params)
    @post.save!
    redirect_to root_path
  end

  def edit
    @user = current_user
    @post = Post.find(params[:id])
  end

  private

  def user_params
    params.require(:post).permit(:expression, :reading, :meaning, :content)
  end
end


